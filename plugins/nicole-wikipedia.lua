function run(msg, matches)
  return get_nicole(msg, matches[1], "wikipedia")
end

return {
    description = "Nicole Wikipedia",
    usage = "!defina (palavra ou termo)",
    patterns = {"^!defina (.*)$"},
    run = run
}

