function get_nicole_xingue(msg, cmd)
  print("Executando Nicole-Xingue", cmd)
  b = http.request("http://keyo.me/nicole/xingue/?q=" .. url_encode(cmd))
  array = json:decode(b)
  if (array.img) then
    file = download_to_file(array.img)
    send_photo(get_receiver(msg), file, ok_cb, false)
  elseif (array.media) then
    file = download_to_file(array.media)
    send_audio(get_receiver(msg), file, ok_cb, false)
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
  return get_nicole_xingue(msg, matches[1])
end

return {
    description = "Nicole Xingue",
    usage = "!xingue (nome)",
    patterns = {"^!xingue (.*)$"},
    run = run
}

