function ok_cb(extra, success, result)
	--funcao de callback que faz porra nenhuma e é obrigatória pra send_msg funcionar
end

function giveWord()
    sentences = {
      "50 tons de cinza",
      "o iluminado",
      "três solteirões e um bebê",
      "crepúsculo",
      "rambo",
      "star wars",
      "superman",
      "batman",
      "pearl harbor",
      "friends",
      "csi",
      "the big bang theory",
      "harry potter",
      "titanic",
      "o poderoso chefão",
      "o senhor dos anéis",
      "clube da luta",
      "matrix",
      "o silêncio dos inocentes",
      "os caçadores da arca perdida",
      "gladiador",
      "alien",
      "frozen",
      "o rei leão",
      "wall-e",
      "toy story",
      "o sexto sentido",
      "breaking bad",
      "game of thrones",
      "os simpsons",
      "dragon ball",
      "futurama",
      "procurando nemo",
      "kill bill",
      "o mágico de oz",
      "tubarão",
      "o exterminador do futuro",
      "de volta para o futuro",
      "jurassic park",
      "a bela e a fera",
      "branca de neve e os sete anões",
      "tomb raider",
      "crash bandicoot",
      "god of war",
      "planeta dos macacos",
      "half life",
      "counter strike",
      "the legend of zelda",
      "metroid",
      "minecraft",
      "bioshock",
      "resident evil",
      "super mario bros",
      "call of duty",
      "metal gear solid",
      "tetris",
      "portal",
      "final fantasy",
      "gta",
      "street fighter",
      "sonic",
      "the sims",
      "sim city",
      "pac man",
      "a bruxa de blair",
      "diário de um banana",
      "o chamado",
      "o grito",
      "pânico",
      "um tira no jardim de infância",
      "a lagoa azul",
      "curtindo a vida adoidado",
      "meu primeiro amor",
      "karate kid",
      "os caça fantasmas",
      "loucademia de polícia",
      "esqueceram de mim",
      "edward mãos de tesoura",
      "rocky",
      "et",
      "ghost",
      "jumanji",
      "uma linda mulher",
      "free willy",
      "a família addams",
      "debi e lóide",
      "top gun",
      "highlander",
      "o máscara",
      "riquinho",
      "mortal kombat",
      "duck hunt",
      "donkey kong",
      "alone in the dark",
      "pokemon",
      "digimon"}

    math.randomseed(os.time())
    x = math.random(1,#sentences)
    return sentences[x]
end

function load_json()
	local f = assert(io.open('./res/guess.json', "r"))
	local c = f:read "*a"
 	local config = json:decode(c)
	f:close()
 	return config
end

function save_json(table)
    file = io.open ("./res/guess.json", "w")
	local json = json:encode_pretty(table)
	file:write(json)
	file:close()
end

function run(msg, matches)
    if(matches[1] == "!guess") then
        tabela = load_json()
        vardump(tabela)
        
        if(tabela[1] == nil) then    
            palavra = giveWord();
            send_msg(msg.from.print_name, "Sua palavra é '" .. palavra .. "'. A partir de agora, envie somente emojis.", ok_cb, false)   
            tabelanova = {msg.from.print_name, msg.from.first_name, palavra, os.time()}
            save_json(tabelanova)
            return "\240\159\148\174 Uma palavra foi enviada para " .. msg.from.first_name .. ". Agora ele só pode se comunicar com emojis.";
        elseif(tabela[1] ~= nil and tabela[1] ~= "") then
            return "\240\159\148\174 Está na vez de " .. tabela[2] .. ". Espere pra poder jogar."
        end
    else
        tabela = load_json()
        if(msg.from.print_name == tabela[1]) then --jogador falando
            testar = string.match(msg.text, "%a")             
            if(testar ~= nil) then 
                --perdeu
                tabelanova = { }
                save_json(tabelanova)
                return "\240\159\148\174 " .. tabela[2] .. " não falou com emojis e perdeu. A palavra era '" .. tabela[3] .. "'. Quem quiser jogar agora envie !guess"
            else
                tabela[4] = os.time()
                save_json(tabela)
            end
        else --participante falando
            
            --testa timeout
            if((tabela[4] + 240) < os.time()) then
                tabelanova = { }
                save_json(tabelanova)
                return "\240\159\148\174 " .. tabela[2] .. " não escreveu nada por muito tempo. A palavra era '" .. tabela[3] .. "'. Quem quiser jogar agora envie !guess";
            end
                    
            if(string.lower(msg.text) == tabela[3]) then
                tabelanova = { }
                save_json(tabelanova)
                return "\240\159\148\174 " .. msg.from.first_name .. " acertou! A palavra era '" .. tabela[3] .. "'. Quem quiser jogar agora envie !guess"
            end
            
            --chegou perto
            if(string.len(msg.text) >= 4 and string.find(tabela[3], string.lower(msg.text)) ~= nil) then
                return "\240\159\148\174 " .. msg.from.first_name .. " chegou bem perto da palavra!"
            end
        end
    end
end

return {
    description = "Jogo de adivinhar filme / livro / série / jogo apenas com emojis.",
    usage = "!guess",
    patterns = { "(.*)"},
    run = run
}
