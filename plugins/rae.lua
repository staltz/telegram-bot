function getDulcinea( text )
  -- Powered by https://github.com/javierhonduco/dulcinea
  local api = "http://dulcinea.herokuapp.com/api/?query="
  local query_url = api..text
  b = http.request(query_url)
  dulcinea = json:decode(b)
  if dulcinea.status == "error" then
    return "Error: " .. dulcinea.message
  end
  while dulcinea.type == "multiple" do
    text = dulcinea.response[1].id
    b = http.request(api..text)
    dulcinea = json:decode(b)
  end
  local text = ""
  local responses = #dulcinea.response
  if responses == 0 then
    return "Error: 404 word not found"
  end
  if (responses > 5) then
    responses = 5
  end
  for i = 1, responses, 1 do 
    text = text .. dulcinea.response[i].word .. "\n"
    local meanings = #dulcinea.response[i].meanings
    if (meanings > 5) then
      meanings = 5
    end
    for j = 1, meanings, 1 do
      local meaning = dulcinea.response[i].meanings[j].meaning 
      text = text .. meaning .. "\n\n"
    end
  end
  print (text)
  return text
end

function run(msg, matches)
  return getDulcinea(matches[1])
end

return {
  description = "Spanish dictionary", 
  usage = "!rae [word]: Search that word in Spanish dictionary. Powered by https://github.com/javierhonduco/dulcinea",
  patterns = {"^!rae (.*)$"}, 
  run = run 
}

