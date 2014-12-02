function run(msg, matches)
	math.randomseed(os.time())
    x = math.random(1,3)
	if x == 2 then
		return "🌝"
	end
end

return {
    description = "reacts to 🌝 emoticon (33% chance)", 
    usage = "Use 🌝 in a message ",
    patterns = {"🌝"}, 
    run = run 
}
