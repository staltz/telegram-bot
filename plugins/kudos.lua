function run(msg, matches)
  
  --return matches[1] .. "recebeu kudos!";
  kudosGiver = msg.from;
  
  return kudosGiver.first_name .. " " .. kudosGiver.last_name .. " deu kudos para " .. matches[1];
  
end

return {
  description = "Dá um kudos pro [usuario]",
  usage = "!kudos [usuario]",
  patterns = {"^!kudos (.*)$"},
  run = run
}
