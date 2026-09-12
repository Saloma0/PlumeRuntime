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
