function run(msg, matches)
  if string.find(matches[1]," ou ") ~= 0 then
    sentences = {"sim", "não"}
    math.randomseed(os.time())
    x = math.random(1,2)
    return sentences[x]
  end
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
