function getName(firstName, lastName)
{
  if(lastName == nill || string.len(lastName) == 0)
  then
    return firstName;
  else
    return firstName .. " " .. lastName;
  end
}

function run(msg, matches)
  
  kudosGiver = msg.from;
  kudosGiverName = getName(kudosGiver.first_name, kudosGiver.last_name);
  
  print(kudosGiver.id);
  
  for id, user in pairs(_users) do
    if id == kudosGiver.id then
      print('>> ACHAMOS! Foi o ' .. getName(user.first_name, user.last_name));
    else
      print('Não foi o ' .. getName(user.first_name, user.last_name));
    end
  end
  
  return kudosGiverName .. " deu kudos para " .. matches[1];
  
end

return {
  description = "Dá um kudos pro [usuario]",
  usage = "!kudos [usuario]",
  patterns = {"^!kudos (.*)$"},
  run = run
}
