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

function addToKudosJSON(currentKudos)

  local f = io.open('./res/kudos.json', "a");
  local c = f:read "*a";
  local allKudos = json:decode(c);
  
  if(allKudos == nil)
  then
    allKudos = {};
  end
  
  table.insert(allKudos, currentKudos);
  
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
  
  --pegando o nome de quem deu kudos
  local kudosGiverName = getName(kudosGiver.first_name, kudosGiver.last_name);
  
  --configurando o kudos atual
  local currentKudos = {};
  currentKudos.id = kudosGiver.id;
  currentKudos.to = matches[1];
  
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
