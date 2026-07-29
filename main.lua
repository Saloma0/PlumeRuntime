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


---http---
function request(options)
    options = options or {}
    local method = options.Method or "GET"
    local url = options.Url or "desconhecido"
    
    info("Enviando requisição " .. method .. " para " .. url)
end


---execution---
info("Ola")

printidentity()
print(identifyexecutor())
print(checkcaller())
luaversion()

print("Hello, World")
info("Hello, World")
warn("Hello, World")
erro("Hello, World")

request({ Method = "GET", Url = "https://api.github.com" })
