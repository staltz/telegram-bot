function run(msg, matches)
    return get_nicole(msg, matches[1], "game-numeros")
end

return {
    description = "Game de adivinhar os numeros",
    usage = "!n (numero de chute)",
    patterns = {"^!n (.*)$"},
    run = run
}
