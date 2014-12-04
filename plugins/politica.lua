function run(msg, matches)
    return "aff politica"
end

return {
    description = "reacts to politic chat", 
    usage = "Talk about politics ",
    patterns = {"dilma"," pt","PT","psdb","coxinha","prefeito","paes","cartacapital","veja","estadao","congresso","governo",".gov","politica","governador","voto","votar","votei","marina","lula","g1.com","globo.com","folha.uol"}, 
    run = run 
}
