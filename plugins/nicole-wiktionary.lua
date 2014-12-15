function get_nicole_wikcionario(msg, cmd)
  print("Executando Nicole-Wiktionary", cmd)
  b = http.request("http://keyo.me/nicole/wiktionary/?q=" .. url_encode(cmd))
  array = json:decode(b)
  if (array.img) then
    file = download_to_file(array.img)
    send_photo(get_receiver(msg), file, ok_cb, false)
  elseif (array.media) then
    file = download_to_file(array.media)
    send_document(get_receiver(msg), file, ok_cb, false)
  elseif (array.msg) then
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
  return get_nicole_wikcionario(msg, matches[1])
end

return {
    description = "Nicole Wiktionary",
    usage = "!defina (palavra)",
    patterns = {"^!defina (.*)$"},
    run = run
}

