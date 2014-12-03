function getKeyo()

	b = http.request("https://rawgit.com/diedona/telegram-bot/pedro/userdata/keyo.json");
	local keyo = json:decode(b);
	return keyo;

end

function getSamuel()

	b = http.request("https://rawgit.com/diedona/telegram-bot/pedro/userdata/samuel.json");
	local samuel = json:decode(b);
	return samuel;


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

  --users available
  users = {"samuel", "keyo"};

  --start the main table
  data = {};
  data.samuel = getSamuel();
  data.keyo = getKeyo();

  --user chosen
  user = nil;

  --if nothing has been specified, default to samuel
  if(string.len(trim1(matches[1])) == 0)
  then
    user = "samuel";
  else
    user = trim1(matches[1]);
  end

  --if chosen user doesnt exist
  if(table.contains(users, user))
  then

    math.randomseed(os.time());
    x = math.random(1,#data[user]);

    return data[user][x];

  else

    return "aff sem roleta";

  end

end

return {
    description = "gira a roleta do bla (beta)",
    usage = "!roleta_beta",
    patterns = {"^!roleta_beta(.*)$"},
    run = run
}
