
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

function print_table(tbl)
    for key,obj in pairs(tbl) do
        print(key..':'..obj)
    end
end

function make_summary(freq)
    summary = 'Falou-se de: '
    for key,obj in pairs(freq) do
        summary = summary .. key .. ' (' .. obj .. '), '
    end
    return string.gsub(summary, ", $", "")
end

function get_summary(hours_ago)
    local chat_words = get_chat_words()
    chat_words = filter_with_time(chat_words, hours_ago)
    frequent_words = make_frequency_table(chat_words)
    print_table(frequent_words)
    return make_summary(frequent_words)
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

