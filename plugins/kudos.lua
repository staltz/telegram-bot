function run(msg, matches)
  return matches[1] .. "recebeu kudos!";
end
  return {
  description = "Dá um kudos pro [usuario]",
  usage = "!kudos [usuario]",
  patterns = {"^!kudos (.*)$"},
  run = run
  }
