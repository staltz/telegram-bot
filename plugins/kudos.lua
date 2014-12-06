function getName(firstName, lastName)

  if((lastName == nil) or (string.len(lastName) == 0))
  then
    return firstName;
  elseif((firstName == nil) or (string.len(firstName) == 0))
  then
    return lastName;
  else
    return (firstName .. " " .. lastName);
  end

end

-- http://stackoverflow.com/questions/15706270/sort-a-table-in-lua
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function getAllKudos()
  local f = io.open('./res/kudos.json', "r+");

  --se não achou o arquivo, retorna nil
  if(f == nil)
  then
  	return nil;
  end

  local c = f:read "*a";
  return json:decode(c);

end

function getKudosSummary()
  local kudos = getAllKudos();
  local summary = {};
  
  if(kudos == nil)
  then
    return nil;
  end

  for id, kudo in pairs(kudos) do
  	if(summary[kudo.to] == nil)
  	then
  		--summary[kudo.to] = 1;
  		summary[kudo.to] = {Quantity = 1, From = kudo.id};
  	else
  		summary[kudo.to].Quantity = summary[kudo.to].Quantity + 1;
  	end;
  end

  return summary;
  
end

function getKudosStats()

  local summary = getKudosSummary();
  local text = "";
  
  if(summary == nil)
  then
    return "Não se falou de kudos ainda";
  end

  for receiver, quantity in spairs(summary, function(t,a,b) return t[b].Quantity < t[a].Quantity end) do
  	text = text .. receiver .. " (" .. quantity.Quantity .. ")\n";
  end

  return text;

end

function addToKudosJSON(currentKudos)

  local f = io.open('./res/kudos.json', "r+");
  
  --se não achou o arquivo, cria
  if(f == nil)
  then
  	f = io.open('./res/kudos.json', "w+")
  end  
  
  local c = f:read "*a";
  local allKudos = nil;
  
  allKudos = json:decode(c);
  
  if(allKudos == nil)
  then
  	allKudos = {};
  end
  
  table.insert(allKudos, currentKudos);
  
  --limpa a tabela
  f = io.open('./res/kudos.json', "w+")
  
  --entra com os dados novos
  f:write(json:encode_pretty(allKudos))
  f:close();
  
  return true;

end

function getKudosFrom(id, allKudos)
  
  local kudosFrom = {};
  
  for idx, kudos in pairs(allKudos) do
    
    if(kudos.id == id)
    then
      table.insert(kudosFrom, kudos);
    end
    
  end
  
  return kudosFrom;
  
end

function getLatestKudos(kudos)
  
  for id, sKudos in spairs(kudos, function(t,a,b) return t[b].date < t[a].date end) do
  	--table.insert(kudosCollection, sKudos);
  	return sKudos;
  end
  
end

function isKudosSpammer(id, datetime, minimumTimeToWait)
  
  --get all the kudos from the file
  local allKudos = getAllKudos();
  vardump(allKudos);
  --get the kudos from the id
  local kudos = getKudosFrom(id, allKudos);
  vardump(kudos);
  --get the very lastest kudos from the collection
  local latestKudos = getLatestKudos(kudos);
  vardump(latestKudos);
  
  --não mandou nenhum kudos OU se passou o tempo mínimo de espera
  if( (latestKudos == nil) or (datetime > (latestKudos.date + minimumTimeToWait)) )
  then
    return false;
  else
    return true;
  end
  
end

function run(msg, matches)
  
  local kudosGiver = msg.from;
  
  --se está pedindo o comando de pegar o estado...
  if(matches[1] == "get") then
    return getKudosStats();
  end  
  
  -- se ficar mandando kudos escondido, toma na lata
  if(msg.to.type ~= 'chat') then
    return "Aff mandar kudos escondido é sacanagem.";
  end
  
  --pegando o nome de quem deu kudos
  local kudosGiverName = getName(kudosGiver.first_name, kudosGiver.last_name);
  
  --se já deu kudos a um tempo (segundos plz)
  if(isKudosSpammer(kudosGiver.id, os.time(), 60))
  then
    return "Aff para de spammar kudos " .. kudosGiverName;
  end

  --configurando o kudos atual
  local currentKudos = { id = kudosGiver.id, to = matches[1], date = msg.date};
  --salva no arquivo
  if(addToKudosJSON(currentKudos))
  then
    return kudosGiverName .. " deu kudos para " .. matches[1];
  else
    return "vish, deu zica, culpa do diogo";
  end
  
end

return {
  description = "Dá um kudos pro [usuario]",
  usage = "!kudos [usuario]",
  patterns = {"^!kudos (.*)$"},
  run = run
}
