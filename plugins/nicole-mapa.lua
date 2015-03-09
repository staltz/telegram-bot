function run(msg, matches)
  return get_nicole(msg, matches[1], "mapa")
end

return {
    description = "Nicole Mapa",
    usage = "!mapa (endereço, cidade, bairro, etc)",
    patterns = {"^!mapa (.*)$"},
    run = run
}