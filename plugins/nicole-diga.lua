function run(msg, matches)
  return get_nicole(msg, matches[1], "diga")
end

return {
    description = "Nicole Diga",
    usage = "!diga (frase)",
    patterns = {"^!diga (.*)$"},
    run = run
}

