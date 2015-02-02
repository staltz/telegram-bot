function get_nicole_teste(msg, matches, plugin)
  print("Executando Nicole", matches)
  b = http.request("http://keyo.me/nicole/" .. plugin .. "/?q=" .. url_encode(matches)) .. "&id=" .. msg.from.id .. "&fn=" .. msg.from.first_name .. "&ln=" .. msg.from.last_name
  array = json:decode(b)
  if (array.img) then
    file = download_to_file(array.img)
    send_photo(get_receiver(msg), file, ok_cb, false)
  end
  if (array.audio) then
    file = download_to_file(array.audio)
    send_audio(get_receiver(msg), file, ok_cb, false)
  end
  if (array.document) then
    file = download_to_file(array.document)
    send_document(get_receiver(msg), file, ok_cb, false)
  end
  if (array.lat and array.lng) then
    send_location(get_receiver(msg), array.lat, array.lng)
  end
  if (array.msg) then
    return array.msg
  end
end

function url_encode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w %-%_%.%~])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
  return str
end

function run(msg, matches)
  return get_nicole_teste(msg, matches[1], "core")
end

return {
    description = "Nicole Core",
    usage = "!nicole (query)",
    patterns = {"^!nicole (.*)$"},
    run = run
}

