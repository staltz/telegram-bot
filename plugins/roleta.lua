function getJsonData(name)

	local information = {};

	local messages = nil;

	if unexpected_condition then error(); end
	b = http.request("https://rawgit.com/diedona/telegram-bot/pedro/userdata/"..name..".json");

	if unexpected_condition then error(); end
	messages = json:decode(b);

	information.messages = messages;

	return information;

end

function table.contains(table, element)

  --http://stackoverflow.com/questions/656199/search-for-an-item-in-a-lua-list

  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function trim1(s)
  if(s == nil)
  then
    return "";
  else
    return (s:gsub("^%s*(.-)%s*$", "%1"))
  end
end

function run(msg, matches)

  --chosen user
  local user = nil;

  --if nothing has been specified, default to samuel
  if(string.len(trim1(matches[1])) == 0)
  then
    user = "samuel";
  else
    user = trim1(matches[1]);
  end

  local success, information = pcall(getJsonData, user);

  if(success)
  then

	math.randomseed(os.time());
	math.random();math.random();math.random();
	local x = math.random(1, #information.messages);

	return information.messages[x];

  else

	print('FAIL:' .. information);
	return "Não rolou a roleta, aff";

  end


end

return {
    description = "gira a roleta do bla. se não informar username, roda a do samuel.",
    usage = "!roleta [username]",
    patterns = {"^!roleta$"},
    run = run
}
