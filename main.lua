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
    return 8
end

function printidentity()
    print("Current identity is " .. tostring(getthreadidentity()))
end

function checkcaller()
    return true
end

function luaversion()
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

function debug(...)
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
    -- Retorna o ambiente global real do Lua
    return _G
end

function getreg()
    -- Retorna a tabela de registros interna
    return debug.getregistry()
end

---system---
function gethwid()
    return "PLUME-HWID-MOCK-12345"
end

function getfps()
    return 60 -- Simulação de FPS do ambiente
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

---crypt---
local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function base64encode(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i>=2^(i-1) and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

---http---
function request(options)
    options = options or {}
    local method = options.Method or "GET"
    local url = options.Url or "desconhecido"
    
    info("Enviando requisição " .. method .. " para " .. url)
end

function httpget(url)
    info("Baixando dados de: " .. tostring(url))
    return "Conteúdo simulado baixado com sucesso"
end


---execution---
info("--- TESTANDO LOGS ---")
info("Mensagem de informação regular.")
warn("Aviso de atenção no sistema.")
debug("Variável de depuração: valor = 42")
success("Operação concluída com sucesso!")

info("--- TESTANDO EXECUTOR & IDENTITY ---")
printidentity()
print("Nome e Versão do Executor:", identifyexecutor())
print("Nome Direto:", getexecutorname())
print("Call do Executor é válido?:", checkcaller())
luaversion()

info("--- TESTANDO ENVIRONMENT (getgenv) ---")
local env = getgenv()
env.MeuObjetoGlobal = "Plume System Loaded"
print("Acessando variável do ambiente global:", getgenv().MeuObjetoGlobal)

info("--- TESTANDO FILESYSTEM ---")

local salvou = writefile("config_teste.txt", "Tema = Escuro\nSom = Ativado")
if salvou then
    success("Arquivo de teste criado com sucesso!")
    
    if isfile("config_teste.txt") then
        info("Conteúdo lido do arquivo:")
        print(readfile("config_teste.txt"))
    end
end

info("--- TESTANDO SYSTEM & CRYPT ---")
print("HWID do Dispositivo:", gethwid())
print("FPS Atual do Ambiente:", getfps())
local textoCodificado = base64encode("PlumeExecutor")
print("Texto em Base64:", textoCodificado)

info("--- TESTANDO HTTP & NETWORK ---")
request({ Method = "GET", Url = "https://api.github.com" })

info("--- TESTANDO ERRO FINAL ---")

erro("Simulando uma falha crítica no ambiente!")
