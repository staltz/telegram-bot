function run(msg, matches)
	math.randomseed(os.time())
	y = math.random(1,2)
	if(y == 1) then
		return "oi"
	end
end

return {
    description = "Diz oi (50%)", 
    usage = "",
    patterns = {
    	"^oi$",
    	"^Oi$"
    }, 
    run = run 
}
