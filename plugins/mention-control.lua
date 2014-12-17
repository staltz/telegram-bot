function load_json()
	local f = assert(io.open('./res/mention.json', "r"))
	local c = f:read "*a"
 	local config = json:decode(c)
	f:close()
 	return config
end

function run(msg, matches)
	local json_mentions = load_json()
	--vardump(msg.from)

	if(matches[1] == "on") then
		if matches[2] == nil then
			return "Uso: !mention on seunome | !mention off | !mention list"
		end

		if json_mentions[msg.from.print_name] ~= nil then
			--Verifica se alguem ta usando o nome
			for id, user in pairs(json_mentions) do
				if matches[2] == user then		
					send_msg(id, "O " .. msg.from.first_name .. " tentou registrar sua menção. (" .. matches[2] .. ")", ok_cb, false)
					return "O " .. id .. " já está usando esse nome e eu dedurei pra ele."
				end
			end

			json_mentions[msg.from.print_name] = matches[2]
			file_users = io.open ("./res/mention.json", "w")
			local json2 = json:encode_pretty(json_mentions)
			file_users:write(json2)
			file_users:close()
			return "Sua menção foi alterada para " .. " #" .. matches[2]
		else
			json_mentions[msg.from.print_name] = matches[2]
			file_users = io.open ("./res/mention.json", "w")
			local json2 = json:encode_pretty(json_mentions)
			file_users:write(json2)
			file_users:close()
			return "Sua menção foi ativada para " .. " #" .. matches[2]
		end		
	end

	if(matches[1] == "off") then
		if json_mentions[msg.from.print_name] == nil then
			return "Aff cê nem ligou menção pro seu usuário ainda..."
		else
			json_mentions[msg.from.print_name] = nil
			file_users = io.open ("./res/mention.json", "w")
			local json2 = json:encode_pretty(json_mentions)
			file_users:write(json2)
			file_users:close()
			return "Menções desativadas para você"
		end		
	end		

	if(matches[1] == "list") then
		local retorno = "Menções gravadas: "
		local primeiro = 1
		for id, user in pairs(json_mentions) do
			if primeiro == 0 then
				retorno = retorno .. " | "
			end
			retorno = retorno .. " #" .. user
			primeiro = 0
		end
		return retorno
	end

	return "Uso: !mention on seunome | !mention off | !mention list"
end

return {
    description = "Controle do plugin mention.lua", 
    usage = "",
    patterns = {
    	"^!mention (.*) (.*)$",
		"^!mention (.*)$",
    }, 
    run = run 
}
