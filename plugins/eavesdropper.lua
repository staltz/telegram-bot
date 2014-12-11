ignored_words = {
    '', 'o','e','a','de','pra','do','da','para','que','q','eu','ele',
    'vc','vo','sem','no','na','esse','essa','este','esta','aquele','aquela',
    'prefiro','aqueles','aquelas','por','ta','acha','acho','dele','dela',
    'como','muito','muita','mto','mta','tem','tinha','é','achei','achou',
    'dos','das','tao','tão','com','sim','não','nao','n','s','sss','nnn',
    'ss','nn','uma','um','dois','duas','tipo','tambem','tbm','também','te',
    'até','nos','nas','tá','se','em','cada','minha','minhas','meu','meus',
    'desde','tmbm','mas','as','os','merda','isso','isto','mesmo','mesma',
    'bem','alguma','alguns','algum','sei','vai','dar','depois','antes','aqui',
    'to','só','so','estou','você','voce','ja','já','pro','mais','tudo','faz',
    'porque','mim','nem','seu','seus','sua','suas','ou','vou','ter', 'aí', 'usar',
    'favor', 'mudar', 'são', 'né', 'quer', 'oo', 'junto', 'deixa', 'além', 'falar',
    'ser', 'todos', 'fazer', 'muda', 'fez', 'deu', 'deve', 'ainda', 'quantas',
    'quantos', 'quanta', 'quanto', 'etc', 'uso', 'qual', 'gente', 'podia', 'pode',
    'daí', 'vem', 'oi', 'ah', 'está', 'estão', 'num', 'me', 'lol', 'via', 'aff',
    'afe', 'afff', 'fica', 'ué', 'pq', 'hmm', 'aham', 'tive', 'xd', ':d', ':p',
    ':)', 'sair', 'posta', 'dá', 'foi', 'lá', 'tal', 'hm', 'sobre', 'deveria',
    'ai', 'ow', 'quando', 'quem', 'xdd', 'xddd', 'vdd', 'nesse', 'ver', 'sou',
    'cara', 'rs', 'era', 'tenho', 'consegue', 'nada', 'mt', 'teve', 'po', 'quero',
    'fui', 'posso', 'coisa', 'ela', 'vcs', 'entao', 'então', 'voces', 'vocês',
    'falou', 'é', 'agora', 'tava', 'estava', 'era', 'olha', 'ih', 'fiz', 'outro',
    'outra', 'preciso', 'precisa', 'ir', 'desse', 'daria', 'falei', 'ao',
    'apenas', 'traz', 'tanta', 'tanto', 'beleza', 'nenhum', 'nenhuma', 'virou',
    'pois',
}

function get_chat_words()
    local f = io.open('./res/chatwords.json', 'r+')
    if f == nil then
        f = io.open('./res/chatwords.json', 'w+')
        f:write('{}') -- Write empty table
        f:close()
        return {}
    else
        local c = f:read '*a'
        f:close()
        return json:decode(c)
    end
end

chat_words = get_chat_words()

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

function prepare_word(word)
    if string.find(word, '^%!') then
        return ''
    end
    xword = string.gsub(word, '%?', '')
    xword = string.gsub(xword, '%.', '')
    xword = string.gsub(xword, '%,', '')
    xword = string.gsub(xword, '%!', '')
    xword = string.gsub(xword, '"', '')
    xword = string.lower(xword)
    return xword
end

function update_chat_words(message)
    for word in string.gmatch(message, '%S+') do
        word = prepare_word(word)
        if not inTable(ignored_words, word) then
            local word_and_time = {word=word, time=os.time()}
            table.insert(chat_words, word_and_time)
        end
    end
end

function should_purge_seconds(word_and_time, seconds_ago)
    if word_and_time.time < os.time()-seconds_ago then
        return true
    else
        return false
    end
end

function should_purge(word_and_time, hours_ago)
    return should_purge_seconds(word_and_time, hours_ago * 60 * 60)
end

function purge_old_chat_words(hours_ago)
    local i=1
    while i <= #chat_words do
        if should_purge(chat_words[i], hours_ago) then
            table.remove(chat_words, i)
        else
            i = i + 1
        end
    end
end

function save_chat_words()
    math.randomseed(os.time())
    if math.random(1,5) == 1 then return nil end
    local json_text = json:encode_pretty(chat_words)
    file = io.open ('./res/chatwords.json', 'w+')
    file:write(json_text)
    file:close()
end

function run(msg, matches)
    update_chat_words(msg.text)
    purge_old_chat_words(24)
    save_chat_words()
end

return {
    patterns = {'(.*)'},
    run = run
}

