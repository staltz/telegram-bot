function getPoliticsWords()
    return {
        "dilma","pt","psdb",
        "coxinha","prefeito",
        "paes","cartacapital",
        "veja","estadao","congresso",
        "governo",".gov","politica",
        "governador","voto","votar",
        "votei","marina","lula","g1.com",
        "globo.com","folha.uol"
    };
end

function run(msg, matches)
    --return "aff politica"
    
    print('politics');
    
end

return {
    description = "reacts to politic chat", 
    usage = "Talk about politics ",
    --patterns = {"dilma","pt","psdb","coxinha","prefeito","paes","cartacapital","veja","estadao","congresso","governo",".gov","politica","governador","voto","votar","votei","marina","lula","g1.com","globo.com","folha.uol"}, 
    patterns = {'(.*)'}, --taken from stalt's eavesdropper
    run = run 
}
