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

function getKudosStats()

  local f = io.open('./res/kudos.json', "r+");

  --se não achou o arquivo, reclama
  if(f == nil)
  then
  	return "Nada de Kudos ainda... Culpa do diogo. Ou do doná bugando bot.";
  end

  local c = f:read "*a";
  local kudos = json:decode(c);
  local summary = {};
  local text = "";

  for id, kudo in pairs(kudos) do
  	if(summary[kudo.to] == nil)
  	then
  		summary[kudo.to] = 1;
  	else
  		summary[kudo.to] = summary[kudo.to] + 1;
  	end;
  end

  for receiver, quantity in spairs(summary, function(t,a,b) return t[b] < t[a] end) do
  	text = text .. receiver .. " (" .. quantity .. ")\n";
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

function run(msg, matches)
  
  local kudosGiver = msg.from;
  
  -- se ficar mandando kudos escondido, toma na lata
  if(msg.to.type ~= 'chat') then
    return "Aff mandar kudos escondido é sacanagem.";
  end
  
  --se está pedindo o comando de pegar o estado...
  if(matches[1] == "get") then
    return getKudosStats();
  end
  
  --pegando o nome de quem deu kudos
  local kudosGiverName = getName(kudosGiver.first_name, kudosGiver.last_name);
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
