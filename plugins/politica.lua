function run(msg, matches)
    return "aff politica"
end

return {
    description = "reacts to politic chat",
    usage = "Just talk about politics",
    patterns = {"(dilma|aécio|PT|pt|psdb|prefeito|paes|cartacapital|veja|estadao|congresso|governo)"},
    run = run
}

