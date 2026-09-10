# 🪶 PlumeRuntime Executor — Luau

> 🇺🇸 **English** · 🇧🇷 **Português**

---

# 🇺🇸 English

## 📖 About

**Plume Executor — Mock API** is a simulated implementation of several APIs commonly found in Lua/Roblox execution environments.

The project is designed for **local testing, API prototyping, demonstrations, and compatibility testing**. It provides mock implementations for executor identification, logging, environments, filesystem operations, HTTP requests, clipboard, Drawing, console functions, and more.

> ⚠️ **Disclaimer:** This project is **not a real Roblox executor**. Several APIs are intentionally simulated and do not interact with Roblox or external services.

---

## ✨ Features

- 🆔 Executor identification
- 🧵 Thread identity simulation
- 📝 Logging system
- 🌎 Lua environment helpers
- 🔧 Metatable utilities
- 🔒 Readonly-state simulation
- 💻 System information mocks
- 📁 Filesystem operations
- 🔐 Base64 encoding
- 🌐 Simulated HTTP requests
- 📋 In-memory clipboard
- 🎨 Simplified Drawing API
- 🖥️ RConsole utilities
- 🧪 Integrated API tests

---

## 🆔 Executor API

```lua
identifyexecutor()
getexecutorname()
getthreadidentity()
printidentity()
checkcaller()
luaversion()
```

### 📌 Mock values

| Function | Value |
|---|---|
| `identifyexecutor()` | `Plume`, `1.0.0` |
| `getexecutorname()` | `Plume` |
| `getthreadidentity()` | `3` |
| `checkcaller()` | `true` |
| `luaversion()` | `0.0.1` |

Example:

```lua
printidentity()

print("Executor:", getexecutorname())
print("Identity:", getthreadidentity())
```

---

## 📝 Logging

Available functions:

```lua
info(...)
warn(...)
log_debug(...)
success(...)
erro(...)
```

Example:

```lua
info("Hello!")
warn("Warning!")
log_debug("Debug information")
success("Operation completed!")
erro("Something went wrong!")
```

Output prefixes:

```text
[INFO]
[WARN]
[DEBUG]
[SUCCESS]
[ERRO]
```

---

## 🌎 Environment

```lua
getgenv()
getrenv()
getreg()
```

### `getgenv()`

Returns a dedicated environment table:

```lua
local env = getgenv()

env.MyGlobal = "Plume System Loaded"

print(getgenv().MyGlobal)
```

### `getrenv()`

Returns `_G`:

```lua
print(getrenv() == _G)
```

### `getreg()`

Attempts to return Lua's debug registry:

```lua
local registry = getreg()

print(type(registry))
```

If `debug.getregistry()` is unavailable, an empty table is returned.

---

## 🔧 Metatables & Hooks

Available functions:

```lua
getrawmetatable(tbl)
setrawmetatable(tbl, newmt)
setreadonly(tbl, readOnly)
isreadonly(tbl)
```

Example:

```lua
local myTable = {}

local meta = {
    __index = {
        test = "Metatable Success"
    }
}

setrawmetatable(myTable, meta)

print(myTable.test)
```

### 🔒 Readonly

```lua
setreadonly(myTable, true)
print(isreadonly(myTable))
```

> ⚠️ `isreadonly()` currently returns `false` as a placeholder. The readonly implementation is intentionally simplified.

---

## 💻 System

Available functions:

```lua
gethwid()
getfps()
isgameactive()
```

Mock values:

```text
HWID: PLUME-HWID-MOCK-12345
FPS: 60
Game Active: true
```

Example:

```lua
print("HWID:", gethwid())
print("FPS:", getfps())
print("Active:", isgameactive())
```

> 🔐 The HWID is completely fictional and does not represent a real hardware identifier.

---

## 📁 Filesystem

Available functions:

```lua
writefile(filename, content)
readfile(filename)
appendfile(filename, content)
isfile(filename)
delfile(filename)
makefolder(folderPath)
delfolder(folderPath)
isfolder(folderPath)
listfiles(folderPath)
```

Example:

```lua
writefile("config.txt", "Plume on top!")

print(readfile("config.txt"))

appendfile("config.txt", " Updated!")

print(readfile("config.txt"))
```

Create a folder:

```lua
makefolder("PlumeFolder")

print(isfolder("PlumeFolder"))
```

> ⚠️ Filesystem operations depend on the permissions of the Lua environment and operating system.

### 📋 `listfiles()`

The current implementation returns a simulated list:

```text
<folder>/config.json
<folder>/script.lua
```

---

## 🔐 Cryptography

The project includes a Base64 encoder:

```lua
base64encode(data)
```

Example:

```lua
local encoded = base64encode("PlumeExecutor")

print(encoded)
```

Result:

```text
UGx1bWVFeGVjdG9y
```

> ℹ️ Base64 is an encoding format, not encryption.

---

## 🌐 HTTP

Available functions:

```lua
request(options)
httpget(url, customHeaders)
```

Example:

```lua
local response = request({
    Method = "GET",
    Url = "https://example.com"
})

print(response.StatusCode)
print(response.Body)
```

The mock response looks like:

```lua
{
    Success = true,
    StatusCode = 200,
    StatusMessage = "OK",
    Headers = finalHeaders,
    Body = "Conteúdo simulado baixado com sucesso"
}
```

### 🧩 Generated headers

The implementation can generate:

```text
User-Agent
Roblox-Session-Id
Roblox-Place-Id
Roblox-Game-Id
Exploit-Identifier
Exploit-Guid
Fingerprint
Accept
```

> ⚠️ **No real HTTP request is performed.** The function simply returns a simulated response.

---

## 📋 Clipboard

Available functions:

```lua
setclipboard(text)
getclipboard()
```

Example:

```lua
setclipboard("Hello from Plume!")

print(getclipboard())
```

The clipboard is stored in memory:

```lua
local _clipboardCache = ""
```

> ℹ️ This does **not** access the operating system's native clipboard.

---

## 🎨 Drawing API

A simplified Drawing API is provided:

```lua
Drawing.new(shapeType)
```

Example:

```lua
local drawing = Drawing.new("Square")

print(drawing.Visible)

drawing:Remove()

print(drawing.Visible)
```

Objects contain:

```lua
Visible
Color
Position
Remove()
```

> ⚠️ No actual graphics are rendered on screen. This is only an API mock.

---

## 🖥️ RConsole

Available functions:

```lua
rconsoleprint(text)
rconsoleclear()
rconsolename(title)
```

Example:

```lua
rconsolename("Plume Executor Console")

rconsoleprint("Hello from Plume!\n")
```

The implementation uses standard Lua I/O and operating-system commands where supported.

---

## 🧪 Built-in Tests

The supplied script contains tests for every major API category:

```lua
info("--- testing logs ---")
info("--- testing executor and identity ---")
info("--- testing environment ---")
info("--- testing filesystem ---")
info("--- testing system and crypto ---")
info("--- testing HTTP ---")
info("--- testing clipboard ---")
info("--- testing metatables ---")
info("--- testing Drawing API ---")
info("--- testing RConsole ---")
```

A typical output will look similar to:

```text
[INFO] --- testing logs ---
[INFO] Regular information message.
[WARN] Warning message.
[DEBUG] Debug variable: value = 42
[SUCCESS] Operation completed successfully!

[INFO] --- testing executor and identity ---
Current identity is 3

[INFO] --- testing system and crypto ---
HWID: PLUME-HWID-MOCK-12345
FPS: 60
Game Active: true
Base64: UGx1bWVFeGVjdG9y

[INFO] --- testing HTTP ---

[INFO] --- testing clipboard ---

[INFO] --- testing Drawing API ---

[INFO] --- testing RConsole ---

[ERRO] test error
```

Exact output may vary depending on the Lua implementation and operating system.

---

## ⚠️ Limitations

### 🌐 HTTP

`request()` does not connect to the internet.

### 📋 Clipboard

Clipboard operations are memory-only.

### 🎨 Drawing

Drawing objects are simulated and are not rendered.

### 🔒 Readonly

`setreadonly()` is simplified and does not implement a complete protected-table system.

### 🎮 Roblox

The project does not provide a Roblox execution engine. Objects such as:

```lua
game.PlaceId
game.JobId
```

only work when the host environment provides them.

---

## 🛠️ Compatibility

The implementation primarily uses standard Lua APIs:

```text
io
os
debug
table
string
```

Compatibility depends on the Lua implementation and the permissions available to the process.

---

## 🎯 Recommended Uses

This project is useful for:

- 🧪 API compatibility testing
- 🧰 Lua development
- 🧱 Mock/prototype development
- 📚 Learning Lua APIs
- 🔍 Automated testing
- 🖥️ Local demonstrations
- 🔌 Testing scripts that depend on executor-style APIs

---

## 📜 License

Add an appropriate license before distributing the project publicly.

---

# 🇧🇷 Português

## 📖 Sobre

O **Plume Executor — Mock API** é uma implementação **simulada** de diversas APIs normalmente encontradas em ambientes de execução Lua/Roblox.

O projeto foi desenvolvido para **testes locais, prototipagem, demonstrações e testes de compatibilidade**. Ele fornece implementações simuladas para identificação do executor, logs, ambientes Lua, filesystem, HTTP, clipboard, Drawing, console e outras funcionalidades.

> ⚠️ **Aviso:** este projeto **não é um executor Roblox real**. Diversas APIs são propositalmente simuladas e não interagem com o Roblox ou com serviços externos.

---

## ✨ Recursos

- 🆔 Identificação do executor
- 🧵 Simulação de identidade da thread
- 📝 Sistema de logs
- 🌎 Manipulação de ambientes Lua
- 🔧 Utilitários de metatables
- 🔒 Simulação de estado readonly
- 💻 Informações de sistema simuladas
- 📁 Operações de filesystem
- 🔐 Codificação Base64
- 🌐 Requisições HTTP simuladas
- 📋 Clipboard em memória
- 🎨 Drawing API simplificada
- 🖥️ Utilitários RConsole
- 🧪 Testes integrados das APIs

---

## 🆔 API do Executor

```lua
identifyexecutor()
getexecutorname()
getthreadidentity()
printidentity()
checkcaller()
luaversion()
```

### 📌 Valores simulados

| Função | Valor |
|---|---|
| `identifyexecutor()` | `Plume`, `1.0.0` |
| `getexecutorname()` | `Plume` |
| `getthreadidentity()` | `3` |
| `checkcaller()` | `true` |
| `luaversion()` | `0.0.1` |

Exemplo:

```lua
printidentity()

print("Executor:", getexecutorname())
print("Identity:", getthreadidentity())
```

---

## 📝 Sistema de Logs

Funções disponíveis:

```lua
info(...)
warn(...)
log_debug(...)
success(...)
erro(...)
```

Exemplo:

```lua
info("Olá!")
warn("Aviso!")
log_debug("Informação de debug")
success("Operação concluída!")
erro("Algo deu errado!")
```

Os prefixos utilizados são:

```text
[INFO]
[WARN]
[DEBUG]
[SUCCESS]
[ERRO]
```

---

## 🌎 Environment

```lua
getgenv()
getrenv()
getreg()
```

### `getgenv()`

Retorna uma tabela dedicada para o ambiente:

```lua
local env = getgenv()

env.MeuGlobal = "Plume System Loaded"

print(getgenv().MeuGlobal)
```

### `getrenv()`

Retorna `_G`:

```lua
print(getrenv() == _G)
```

### `getreg()`

Tenta obter o registry do Lua através de:

```lua
debug.getregistry()
```

Caso a função não esteja disponível, uma tabela vazia é retornada.

---

## 🔧 Metatables & Hooks

Funções disponíveis:

```lua
getrawmetatable(tbl)
setrawmetatable(tbl, newmt)
setreadonly(tbl, readOnly)
isreadonly(tbl)
```

Exemplo:

```lua
local minhaTabela = {}

local meta = {
    __index = {
        teste = "Sucesso Metatable"
    }
}

setrawmetatable(minhaTabela, meta)

print(minhaTabela.teste)
```

### 🔒 Readonly

```lua
setreadonly(minhaTabela, true)

print(isreadonly(minhaTabela))
```

> ⚠️ `isreadonly()` atualmente retorna `false` como placeholder. A implementação de readonly é simplificada.

---

## 💻 Sistema

Funções disponíveis:

```lua
gethwid()
getfps()
isgameactive()
```

Valores simulados:

```text
HWID: PLUME-HWID-MOCK-12345
FPS: 60
Game Active: true
```

Exemplo:

```lua
print("HWID:", gethwid())
print("FPS:", getfps())
print("Ativo:", isgameactive())
```

> 🔐 O HWID utilizado é completamente fictício e não representa um identificador real de hardware.

---

## 📁 Filesystem

Funções disponíveis:

```lua
writefile(filename, content)
readfile(filename)
appendfile(filename, content)
isfile(filename)
delfile(filename)
makefolder(folderPath)
delfolder(folderPath)
isfolder(folderPath)
listfiles(folderPath)
```

Exemplo:

```lua
writefile("config.txt", "Plume on top!")

print(readfile("config.txt"))

appendfile("config.txt", " Atualizado!")

print(readfile("config.txt"))
```

Criando uma pasta:

```lua
makefolder("PlumeFolder")

print(isfolder("PlumeFolder"))
```

> ⚠️ As operações de filesystem dependem das permissões do ambiente Lua e do sistema operacional.

### 📋 `listfiles()`

A implementação atual retorna uma lista simulada:

```text
<folder>/config.json
<folder>/script.lua
```

---

## 🔐 Criptografia / Base64

O projeto possui:

```lua
base64encode(data)
```

Exemplo:

```lua
local encoded = base64encode("PlumeExecutor")

print(encoded)
```

Resultado:

```text
UGx1bWVFeGVjdG9y
```

> ℹ️ Base64 é uma forma de **codificação**, não de criptografia.

---

## 🌐 HTTP

Funções disponíveis:

```lua
request(options)
httpget(url, customHeaders)
```

Exemplo:

```lua
local response = request({
    Method = "GET",
    Url = "https://example.com"
})

print(response.StatusCode)
print(response.Body)
```

A resposta simulada possui o formato:

```lua
{
    Success = true,
    StatusCode = 200,
    StatusMessage = "OK",
    Headers = finalHeaders,
    Body = "Conteúdo simulado baixado com sucesso"
}
```

### 🧩 Headers

A implementação pode gerar:

```text
User-Agent
Roblox-Session-Id
Roblox-Place-Id
Roblox-Game-Id
Exploit-Identifier
Exploit-Guid
Fingerprint
Accept
```

> ⚠️ **Nenhuma requisição HTTP real é realizada.** A função apenas retorna uma resposta simulada.

---

## 📋 Clipboard

Funções disponíveis:

```lua
setclipboard(text)
getclipboard()
```

Exemplo:

```lua
setclipboard("Olá do Plume!")

print(getclipboard())
```

O conteúdo é armazenado em memória:

```lua
local _clipboardCache = ""
```

> ℹ️ Isso **não acessa o clipboard nativo** do Windows, Linux ou macOS.

---

## 🎨 Drawing API

Uma Drawing API simplificada está disponível:

```lua
Drawing.new(shapeType)
```

Exemplo:

```lua
local desenho = Drawing.new("Square")

print(desenho.Visible)

desenho:Remove()

print(desenho.Visible)
```

Os objetos possuem:

```lua
Visible
Color
Position
Remove()
```

> ⚠️ Nenhum desenho real é renderizado na tela. Trata-se apenas de um mock da API.

---

## 🖥️ RConsole

Funções disponíveis:

```lua
rconsoleprint(text)
rconsoleclear()
rconsolename(title)
```

Exemplo:

```lua
rconsolename("Plume Executor Console")

rconsoleprint("Olá do Plume!\n")
```

A implementação utiliza APIs padrão de I/O do Lua e comandos do sistema operacional quando disponíveis.

---

## 🧪 Testes Integrados

O código fornecido possui testes para as principais categorias:

```lua
info("--- testando logs ---")
info("--- testando executor e identity ---")
info("--- testando environment ---")
info("--- testando filesystem ---")
info("--- testando system e crypto ---")
info("--- testando HTTP ---")
info("--- testando clipboard ---")
info("--- testando metatables ---")
info("--- testando Drawing API ---")
info("--- testando RConsole ---")
```

Uma saída típica será semelhante a:

```text
[INFO] --- testando logs ---
[INFO] Mensagem de informação regular.
[WARN] Aviso de atenção no sistema.
[DEBUG] Variável de depuração: valor = 42
[SUCCESS] Operação concluída com sucesso!

[INFO] --- testando executor e identity ---
Current identity is 3

[INFO] --- testando system e crypto ---
HWID: PLUME-HWID-MOCK-12345
FPS: 60
Game Active: true
Base64: UGx1bWVFeGVjdG9y

[INFO] --- testando HTTP ---

[INFO] --- testando clipboard ---

[INFO] --- testando Drawing API ---

[INFO] --- testando RConsole ---

[ERRO] erro teste
```

A saída exata pode variar de acordo com a implementação Lua e o sistema operacional.

---

## ⚠️ Limitações

### 🌐 HTTP

`request()` não se conecta à internet.

### 📋 Clipboard

O clipboard funciona somente em memória.

### 🎨 Drawing

Os objetos Drawing são simulados e não são renderizados.

### 🔒 Readonly

`setreadonly()` possui uma implementação simplificada e não fornece um sistema completo de proteção de tabelas.

### 🎮 Roblox

O projeto não fornece um mecanismo de execução do Roblox.

Objetos como:

```lua
game.PlaceId
game.JobId
```

somente funcionarão quando fornecidos pelo ambiente que estiver executando o código.

---

## 🛠️ Compatibilidade

O projeto utiliza principalmente APIs padrão do Lua:

```text
io
os
debug
table
string
```

A compatibilidade depende da implementação do Lua utilizada e das permissões disponíveis ao processo.

---

## 🎯 Usos Recomendados

Este projeto pode ser utilizado para:

- 🧪 Testes de compatibilidade de APIs
- 🧰 Desenvolvimento em Lua
- 🧱 Criação de mocks e protótipos
- 📚 Estudos de APIs Lua
- 🔍 Testes automatizados
- 🖥️ Demonstrações locais
- 🔌 Testar scripts que dependem de APIs no estilo executor

---

## 📜 Licença

Adicione uma licença apropriada antes de distribuir o projeto publicamente.

---

# ⭐ Plume

**Mock it. Test it. Build it.**

🇺🇸 English · 🇧🇷 Português

> ⚠️ This project is intended as a simulated/local API environment and does not claim to provide a real Roblox executor.
