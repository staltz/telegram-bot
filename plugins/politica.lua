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

function getInsults()
    return {
        "aff política", "{user}, tem outras coisas fora política pra falar sabe?",
        "parece um papagaio falando de política {user}, aff",
        "sabe metralhadora de merda? parece o {user} falando de política."
    };
end

function isPolitics(text)
    return true; --stub
end

function getUserName(firstName, lastName)
    
    local fullName = "";
    
    if(firstName ~= nil and string.len(firstName) > 0)
    then
        fullName = firstName;
    end
    
    if(lastName ~= nil and string.len(lastName) > 0)
    then
        if(string.len(fullName) > 0)
        then
            fullName = fullName .. " " .. lastName;
        else
            fullName = lastName;
        end
    end
    
    return fullName;
    
end

function getRandomInsult(From)
    math.randomseed( os.time() )
    math.random(); math.random(); math.random()
    
    local insults = getInsults();
    x = math.random(1, #insults)
    local insult = insults[x];
    local userName = getUserName(From.firs_name, From.last_name);
    
    if(string.match(insult, "{user}"))
    then
        insult = string.gsub(insult, "{user}", userName);
    end
    
    return insult;
end

function run(msg, matches)

    --does it match any political context?
    if(isPolitics(matches[1]))
    then
        
        math.randomseed( os.time() )
        math.random(); math.random(); math.random()
        
        x = math.random(1,2);
        
        if(x == 2)
        then
            return (getRandomInsult(msg.From));
        end
        
    end

end

return {
    description = "reacts to politic chat", 
    usage = "Talk about politics ",
    patterns = {'(.*)'}, --taken from stalt's eavesdropper
    run = run 
}
