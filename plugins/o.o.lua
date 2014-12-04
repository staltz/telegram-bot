function run(msg, matches)
	math.randomseed(os.time())
	y = math.random(1,100)
	if(y == 66) then
		return "o.o"
	end
end

return {
    description = "Diz o.o (1%)", 
    usage = "",
    patterns = {
    	"(.*)"
    }, 
    run = run 
}
