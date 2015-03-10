function ok_cb(extra, success, result)
	--funcao de callback que faz porra nenhuma e é obrigatória pra fwd_msg funcionar
end

function load_json()
	local f = assert(io.open('./res/mention.json', "r"))
	local c = f:read "*a"
 	local config = json:decode(c)
	f:close()
 	return config
end

function run(msg, matches)
	local json_mentions = load_json()
	for id, user in pairs(json_mentions) do
		if matches[1] == user then		
			fwd_msg(id, msg.id, ok_cb, false)
			--print("=============== fwd_msg(" .. id .. ", " .. msg.id .. ", ok_cb, false)")
			return 
		end
	end

	return "Ninguém com menção #" .. matches[1] .. " não encontrado..."

end

return {
    description = "Manda PM pra alguem mencionado", 
    usage = "",
    patterns = {
    	"^#(%w*) (.*)$"
    }, 
    run = run 
}
