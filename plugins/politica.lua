function run(msg, matches)
    return "aff politica"
end

return {
    description = "reage a conversa sobre política", 
    usage = "Falar sobre política ",
    patterns = {"dilma"," pt","pt ","psdb","coxinha","prefeito","paes","cartacapital","veja","estadao","congresso","governo",".gov","politica","governador","voto","votar","votei","marina","lula"}, 
    run = run 
}
