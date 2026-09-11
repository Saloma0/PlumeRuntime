---setup---
local unpack = unpack or table.unpack

---executor---
function identifyexecutor()
    return "Plume", "1.0.0"
end

function getexecutorname()
    return "Plume"
end

function getthreadidentity()
    return 3 ---default---
end

function printidentity()
    print("Current identity is " .. tostring(getthreadidentity()))
end

function checkcaller()
    return true
end

function luaversion()
    return _VERSION
end

function runtimeversion()
    print("0.0.1")
end

---logs---
local function _write(stream, prefix, ...)
    local args = {...}
    for i = 1, #args do
        args[i] = tostring(args[i])
    end
    stream:write(prefix .. table.concat(args, " ") .. "\n")
end

function info(...)
    _write(io.stdout, "[INFO] ", ...)
end

function warn(...)
    _write(io.stdout, "[WARN] ", ...)
end

function log_debug(...)
    _write(io.stdout, "[DEBUG] ", ...)
end

function success(...)
    _write(io.stdout, "[SUCCESS] ", ...)
end

function erro(...)
    _write(io.stdout, "[ERRO] ", ...)
end

---env---
local genv = {}

function getgenv()
    return genv
end

function getrenv()
    return _G
end

function getreg()
    if type(debug) == "table" and type(debug.getregistry) == "function" then
        return debug.getregistry()
    end
    return {}
end

---metatable & hooks---
function getrawmetatable(tbl)
    if type(debug) == "table" and type(debug.getmetatable) == "function" then
        return debug.getmetatable(tbl)
    end
    return getmetatable(tbl)
end

function setrawmetatable(tbl, newmt)
    if type(debug) == "table" and type(debug.setmetatable) == "function" then
        return debug.setmetatable(tbl, newmt)
    end
    return setmetatable(tbl, newmt)
end

function setreadonly(tbl, readOnly)
    local mt = getmetatable(tbl) or {}
    mt.__newindex = readOnly and function() error("Tabela é apenas leitura", 2) end or nil
    setmetatable(tbl, mt)
end

function isreadonly(tbl)
    if type(tbl) ~= "table" then
        return false
    end

    local mt = getmetatable(tbl)

    if mt and mt.__newindex then
        return true
    end

    return false
end

---system---
function gethwid()
    return "PLUME-HWID-MOCK-12345"
end

function getfps()
    return 60
end

function isgameactive()
    return true
end

---filesystem---
function writefile(filename, content)
    local file = io.open(filename, "w")
    if file then
        file:write(content)
        file:close()
        return true
    end
    return false
end

function readfile(filename)
    local file = io.open(filename, "r")
    if file then
        local content = file:read("*a")
        file:close()
        return content
    end
    return nil
end

function appendfile(filename, content)
    local file = io.open(filename, "a")
    if file then
        file:write(content)
        file:close()
        return true
    end
    return false
end

function isfile(filename)
    local file = io.open(filename, "r")
    if file then
        file:close()
        return true
    end
    return false
end

function delfile(filename)
    return os.remove(filename)
end

function makefolder(folderPath)
    return os.execute('mkdir "' .. folderPath .. '"')
end

function delfolder(folderPath)
    return os.execute('rmdir /s /q "' .. folderPath .. '"')
end

function isfolder(folderPath)
    local ok, _, code = os.rename(folderPath, folderPath)
    return ok or code == 13
end

function listfiles(folderPath)
    return { folderPath .. "/config.json", folderPath .. "/script.lua" }
end

---crypt---
local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function base64encode(data)
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i>=2^(i-1) and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

---http---
local function buildHeaders(url, placeId, gameId, hwid)
    local isLuarmor = string.find(url, "luarmor.net") or
                      string.find(url, "luarmor") or
                      string.find(url, "raw.githubusercontent.com")

    local sessionJson = '{"GameId":"' .. tostring(gameId) .. '","PlaceId":"' .. tostring(placeId) .. '"}'
    local exploitName = isLuarmor and "Volt" or getexecutorname()

    local headers = {
        ["User-Agent"] = exploitName,
        ["Roblox-Session-Id"] = sessionJson,
        ["Roblox-Place-Id"] = tostring(placeId),
        ["Roblox-Game-Id"] = tostring(gameId),
        ["Exploit-Identifier"] = exploitName,
        ["Exploit-Guid"] = hwid,
        ["Fingerprint"] = hwid,
        ["Accept"] = "*/*"
    }

    return headers
end

function request(options)
    options = options or {}
    local method = options.Method or "GET"
    local url = options.Url or "desconhecido"
    local customHeaders = options.Headers or {}

    local placeId = (game and game.PlaceId) or 0
    local gameId = (game and game.JobId) or "00000000-0000-0000-0000-000000000000"
    local hwid = gethwid()

    local finalHeaders = buildHeaders(url, placeId, gameId, hwid)
    for k, v in pairs(customHeaders) do
        finalHeaders[k] = v
    end

    info("Enviando requisição " .. method .. " para " .. url)
    for key, value in pairs(finalHeaders) do
        log_debug(key .. " : " .. tostring(value))
    end

    return {
        Success = true,
        StatusCode = 200,
        StatusMessage = "OK",
        Headers = finalHeaders,
        Body = "Conteúdo simulado baixado com sucesso"
    }
end

function httpget(url, customHeaders)
    info("Baixando dados de: " .. tostring(url))
    local response = request({
        Method = "GET",
        Url = url,
        Headers = customHeaders
    })
    return response.Body
end

---clipboard---
local _clipboardCache = ""

function setclipboard(text)
    _clipboardCache = tostring(text)
    return true
end

function getclipboard()
    return _clipboardCache
end

---drawing---
Drawing = {
    new = function(shapeType)
        return {
            Visible = true,
            Color = {255, 255, 255},
            Position = {x = 0, y = 0},
            Remove = function(self) self.Visible = false end
        }
    end
}

---rconsole---
function rconsoleprint(text)
    io.write(text)
end

function rconsoleclear()
    os.execute("cls" or "clear")
end

function rconsolename(title)
    if package.config:sub(1,1) == '\\' then
        os.execute("title " .. title)
    end
end

---execution---
info("--- testando logs ---")
info("Mensagem de informação regular.")
warn("Aviso de atenção no sistema.")
log_debug("Variável de depuração: valor = 42")
success("Operação concluída com sucesso!")

info("--- testando executor e identity ---")
printidentity()
print("Nome e Versão do Executor:", identifyexecutor())
print("Nome Direto:", getexecutorname())
print("Call do Executor é válido?:", checkcaller())
print(luaversion())
print(runtimeversion())

info("--- testando env (getgenv, getrenv, getreg) ---")
local env = getgenv()
env.MeuObjetoGlobal = "Plume System Loaded"
print("Acessando variável do ambiente global:", getgenv().MeuObjetoGlobal)
print("Verificando se _G existe via getrenv:", getrenv() == _G)
print("Tipo do Registry:", type(getreg()))

info("--- testando file system ---")
local salvou = writefile("config_teste.txt", "Plume on top!")
if salvou then
    success("Arquivo de teste criado com sucesso!")

    if isfile("config_teste.txt") then
        info("Conteúdo lido do arquivo:")
        print(readfile("config_teste.txt"))
        
        appendfile("config_teste.txt", " - Atualizado")
        print("Conteúdo após appendfile:", readfile("config_teste.txt"))
    end
end

makefolder("PlumeFolder")
print("É pasta?:", isfolder("PlumeFolder"))
print("Lista de arquivos:", table.concat(listfiles("PlumeFolder"), ", "))

info("--- testando system e cript ---")
print("HWID do Dispositivo:", gethwid())
print("FPS Atual do Ambiente:", getfps())
print("Jogo Ativo?:", isgameactive())
local textoCodificado = base64encode("PlumeExecutor")
print("Texto em Base64:", textoCodificado)

info("--- testando http ---")
local urlTeste = "https://raw.githubusercontent.com/obiiyeuem/somefile"
request({ Method = "GET", Url = urlTeste })
print("HTTP Get Simulada:", httpget("https://google.com"))

info("--- testando clipboard ---")
setclipboard("Texto Copiado para a Plume Clipboard")
print("Conteúdo da Clipboard:", getclipboard())

info("--- testando metatable & hooks ---")
local minhaTabela = {}
local meta = { __index = { teste = "Sucesso Metatable" } }
setrawmetatable(minhaTabela, meta)
print("Verificando metatable:", getrawmetatable(minhaTabela) == meta)
print("Valor via Metatable:", minhaTabela.teste)

setreadonly(minhaTabela, true)
print("Tabela definida como readonly (isreadonly):", isreadonly(minhaTabela))

info("--- testando drawing api ---")
local desenho = Drawing.new("Square")
print("Desenho criado. Visível?:", desenho.Visible)
desenho:Remove()
print("Visível após remoção?:", desenho.Visible)

info("--- testando rconsole ---")
rconsolename("Plume Executor Console")
rconsoleprint("Imprimindo diretamente via rconsoleprint!\n")

info("--- testando erro final ---")
erro("erro teste")
