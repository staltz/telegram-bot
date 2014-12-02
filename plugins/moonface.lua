function run(msg, matches)
    math.randomseed(os.time())
    x = math.random(1,3)
    if x == 2 then
        return "\240\159\140\157"
    end
end

return {
    description = "reacts to :full_moon_with_face: emoticon (33% chance)", 
    usage = "Use \240\159\140\157 in a message ",
    patterns = {"\240\159\140\157"},
    run = run
}
