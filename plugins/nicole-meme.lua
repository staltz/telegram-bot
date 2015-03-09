function run(msg, matches)
  return get_nicole(msg, matches[1], "meme")
end

return {
    description = "Nicole Meme",
    usage = "!meme (fundo) (primeira frase) (,) (segunda frase)",
    patterns = {"^!meme (.*)$"},
    run = run
}

