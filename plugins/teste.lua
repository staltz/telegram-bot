function getKeyo()

	http = require("socket.http")
	json = require("json")

	b = http.request("https://api.myjson.com/bins/3yvs7");
	--b = http.request("https://dl.dropboxusercontent.com/u/85324883/GameList.json");
	local keyo = json.decode(b);
	return keyo;

end

keyo = getKeyo();
print(#keyo)
print(keyo[2])
return 0;
