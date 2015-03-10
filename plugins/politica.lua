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
        "sabe metralhadora de merda? parece o {user} falando de política.",
        "putz, política não gente",
        "agora fala-se de política",
        "{user} c sabe que tá falando merda política né?",
        "virou cientista político {user}?",
        "Vai falar de política com suas nega"
    };
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end

    return false
end

function isPolitics(text)
    
    --pegando todos os padrões de política
    politics = getPoliticsWords();
    --verificação
    local hasPolitics = false;
    --coletando as palavras
    for i in string.gmatch(text, "%S+") do
      
        if(table.contains(politics, i))
        then
            return true;
        end
      
    end
    
    return false;
    
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
    local userName = getUserName(From.first_name, From.last_name);
    
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
        print('tem política');
        
        math.randomseed( os.time() )
        math.random(); math.random(); math.random()
        
        --50% de chance de reagir
        x = math.random(1,2);
        if(x == 2)
        then
            return (getRandomInsult(msg.from));
        end
        
    else
        print('não tem política');
    end

end

return {
    description = "reacts to politic chat", 
    usage = "Talk about politics ",
    patterns = {'(.*)'}, --taken from stalt's eavesdropper
    run = run 
}
