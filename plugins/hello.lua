
function run(msg, matches)
  sentences = {"vai tomar no cu ", "vai se foder ", ":) oi ", "olá ", "Bem vindo "}
  math.randomseed(os.time())
  x = math.random(1,#sentences)
  return sentences[x] .. matches[1]
end

return {
    description = "Cumprimenta uma pessoa", 
    usage = "pedro diga oi pro [name]",
    patterns = {
    	"^pedro diz oi pro (.*)$",
    	"^Pedro diz oi pro (.*)$",
    	"^pedro diga oi pro (.*)$",
    	"^pedro diga oi pra (.*)$",
    	"^pedro diga oi para a (.*)$",
    	"^Pedro diga oi para o (.*)$"
    }, 
    run = run 
}

