function run(msg, matches)
	math.randomseed(os.time())
	y = math.random(1,2)

	if y == 1 then	
		sentences = {"olha a boca suja caralho", 
		"você beija a sua mãe com essa boca suja?",
		"olha o linguajar",
		"olha a boca, você acha que ta falando com as suas nega?",
		"SEM PALAVRÃO PORRA",
		"esse é um chat de família, se for pra ficar falando palavrão então retire-se"}
		math.randomseed(os.time())

		math.random(); math.random(); math.random()
		x = math.random(1,6)
		return sentences[x]
	end
end

return {
    description = "É repreendido pelo Pedro (50%).", 
    usage = "",
    patterns = {
    	"bosta","cacete","porra","caralho","caraio","pinto"," cu ","merda","foda","viado",
		"BOSTA","CACETE","PORRA","CARALHO","CARAIO","PINTO"," CU ","MERDA","FODA","VIADO"
    }, 
    run = run 
}
