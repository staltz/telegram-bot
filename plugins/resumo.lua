
function get_chat_words()
    local f = io.open('./res/chatwords.json', "r+")
    if f == nil then
        f = io.open('./res/chatwords.json', "w+")
        f:write("{}") -- Write empty table
        f:close()
        return {}
    else
        local c = f:read "*a"
        f:close()
        return json:decode(c)
    end
end

function filter_with_time(chat_words, hours_ago)
    local i=1
    while i <= #chat_words do
        if chat_words[i].time < os.time() - (hours_ago * 60 * 60) then
            table.remove(chat_words, i)
        else
            i = i + 1
        end
    end
    return chat_words
end

function make_frequency_table(chat_words)
    freq = {}
    for key,obj in pairs(chat_words) do
        if freq[obj.word] == nil then
            freq[obj.word] = 1
        else
            freq[obj.word] = freq[obj.word] + 1
        end
    end
    return freq
end

function compare_words(a,b)
    return a.amount > b.amount
end

function freq_table_to_array(freq)
    arr = {}
    for word,amount in pairs(freq) do
        print(word..'..'..amount)
        if amount > 1 then
            table.insert(arr, {word=word, amount=amount})
        end
    end
    table.sort(arr, compare_words)
    return arr
end

function print_table(tbl)
    for key,obj in pairs(tbl) do
        print(key..':'..obj)
    end
end

function make_summary(freq)
    summary = 'Falou-se de: '
    for i = 1,#freq do
        summary = summary .. freq[i].word .. ' (' .. freq[i].amount .. '), '
    end
    return string.gsub(summary, ", $", "")
end

function get_summary(hours_ago)
    if hours_ago < 0 then
        return "desculpa, esqueci minha bola de cristal em casa..."
    else
        local chat_words = get_chat_words()
        chat_words = filter_with_time(chat_words, hours_ago)
        frequent_words = make_frequency_table(chat_words)
        frequent_arr = freq_table_to_array(frequent_words)
        return make_summary(frequent_arr)
    end
end

function get_hours(message)
    if message == '' or message == nil or message == '!resumo' then
        return 5
    else
        return tonumber(message)
    end
end

function run(msg, matches)
    return get_summary(get_hours(matches[1]))
end

return {
    description = "resume a conversa nas ultimas horas", 
    usage = "!resumo (horas)h",
    patterns = {
      "^!resumo (.+)h$",
      "^!resumo$"
    },
    run = run
}

