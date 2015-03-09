function run(msg, matches)
  return get_nicole(msg, matches[1], "xingue")
end

return {
    description = "Nicole Xingue",
    usage = "!xingue (nome)",
    patterns = {"^!xingue (.*)$"},
    run = run
}

