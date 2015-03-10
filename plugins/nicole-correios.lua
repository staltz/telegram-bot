function run(msg, matches)
    return get_nicole(msg, matches[1], "correios")
end

return {
    description = "Mostra historico de um objeto SEDEX ou PAC",
    usage = "!correios (codigo da postagem)",
    patterns = {"^!correios (.*)$"},
    run = run
}
