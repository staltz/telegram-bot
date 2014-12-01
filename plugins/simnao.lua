function run(msg, matches)
  sentences = {"sim", "não"}
  math.randomseed(os.time())
  x = math.random(1,2)
  return sentences[x]
end

return {
    description = "Responde a uma pergunta", 
    usage = "Pedro, [alguma pergunta]?",
    patterns = {
    	"^pedro, (.*)%?$",
    	"^Pedro, (.*)%?$"
    }, 
    run = run 
}
