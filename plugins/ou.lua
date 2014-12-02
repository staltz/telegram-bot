function run(msg, matches)
  sentences = {matches[1], matches[2]}
  math.randomseed(os.time())
  x = math.random(1,2)
  return sentences[x]
end

return {
    description = "Responde a uma pergunta", 
    usage = "Pedro, [alguma pergunta] ou [outra pergunta]?",
    patterns = {
    	"^Pedro, (.*) ou (.*)%?$",
    	"^pedro, (.*) ou (.*)%?$"
    }, 
    run = run 
}
