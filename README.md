# PlumeRuntime

### A lightweight Luau/Lua executor-style API mock for local development and compatibility testing.

PlumeRuntime is a **simulated runtime layer** that reproduces the behavior and interfaces of commonly encountered executor-style APIs in a controlled, local environment.

It is intended for **API prototyping, compatibility testing, automated tests, demonstrations, and Lua development**.

> [!WARNING]
> PlumeRuntime is **not a Roblox executor**. It does not inject into Roblox, execute code inside Roblox, bypass security mechanisms, or communicate with Roblox services. Most APIs are intentionally mocked or simplified.

---

## Overview

PlumeRuntime provides a collection of modular mock APIs designed to make scripts that depend on executor-style functions easier to test outside their original environment.

The runtime focuses on predictable behavior, portability, and ease of integration.

### Key capabilities

- Executor identification and version information
- Thread identity simulation
- Logging utilities
- Global and runtime environment helpers
- Metatable utilities
- Read-only state simulation
- System information mocks
- Local filesystem operations
- Base64 encoding
- Simulated HTTP responses
- In-memory clipboard
- Simplified Drawing objects
- Console utilities
- Built-in API validation tests

---

## Installation

Clone or download the project and load the runtime in your Lua/Luau environment.

```lua
dofile("PlumeRuntime.lua")
```

> The exact loading method depends on the host environment and Lua implementation being used.

---

## Quick Start

```lua
print("Executor:", getexecutorname())
print("Version:", identifyexecutor())
print("Thread Identity:", getthreadidentity())

info("PlumeRuntime initialized successfully.")
```

Example output:

```text
Executor: Plume
Version: Plume 1.0.0
Thread Identity: 3
[INFO] PlumeRuntime initialized successfully.
```

---

## API Reference

### Executor Information

| Function | Description |
|---|---|
| `identifyexecutor()` | Returns the simulated executor name and version |
| `getexecutorname()` | Returns the executor name |
| `getthreadidentity()` | Returns the simulated thread identity |
| `printidentity()` | Prints the current identity |
| `checkcaller()` | Returns the simulated caller state |
| `luaversion()` | Returns the configured Lua version |

Example:

```lua
printidentity()

print("Name:", getexecutorname())
print("Identity:", getthreadidentity())
print("Lua:", luaversion())
```

Default mock values:

```text
Executor: Plume
Version: 1.0.0
Identity: 3
Caller: true
Lua Version: 5.4
```

---

### Logging

PlumeRuntime includes a lightweight logging interface.

```lua
info("Informational message")
warn("Warning message")
log_debug("Debug message")
success("Operation completed")
erro("Error message")
```

Output format:

```text
[INFO] Informational message
[WARN] Warning message
[DEBUG] Debug message
[SUCCESS] Operation completed
[ERRO] Error message
```

---

### Environment

```lua
getgenv()
getrenv()
getreg()
```

#### `getgenv()`

Returns a dedicated global environment table.

```lua
local env = getgenv()

env.ApplicationName = "PlumeRuntime"

print(getgenv().ApplicationName)
```

#### `getrenv()`

Returns the host global environment.

```lua
print(getrenv() == _G)
```

#### `getreg()`

Attempts to access the Lua debug registry.

If registry access is unavailable, an empty table is returned.

---

### Metatables

```lua
getrawmetatable(tbl)
setrawmetatable(tbl, metatable)
setreadonly(tbl, state)
isreadonly(tbl)
```

Example:

```lua
local object = {}

setrawmetatable(object, {
    __index = {
        Status = "Available"
    }
})

print(object.Status)
```

> Read-only behavior is currently simulated and should not be considered a complete immutable-table implementation.

---

### System Information

```lua
gethwid()
getfps()
isgameactive()
```

Default values:

```text
HWID: PLUME-HWID-MOCK-12345
FPS: 60
Game Active: true
```

These values are fictional and intended exclusively for testing.

---

### Filesystem

```lua
writefile(path, content)
readfile(path)
appendfile(path, content)
isfile(path)
delfile(path)

makefolder(path)
delfolder(path)
isfolder(path)
listfiles(path)
```

Example:

```lua
writefile("settings.txt", "PlumeRuntime")

appendfile("settings.txt", " initialized")

print(readfile("settings.txt"))
```

Folder example:

```lua
makefolder("PlumeData")

print(isfolder("PlumeData"))
```

> Filesystem behavior depends on the host operating system, process permissions, and runtime implementation.

---

### Encoding

```lua
base64encode(data)
```

Example:

```lua
local result = base64encode("PlumeRuntime")

print(result)
```

Output:

```text
UGx1bWVydW50aW1l
```

Base64 is an **encoding format**, not encryption.

---

### HTTP Mock

```lua
request(options)
httpget(url, headers)
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

Example response:

```lua
{
    Success = true,
    StatusCode = 200,
    StatusMessage = "OK",
    Headers = {},
    Body = "Simulated response body"
}
```

No external network request is performed.

The HTTP layer exists exclusively to test scripts that expect a request-style API.

---

### Clipboard

```lua
setclipboard(text)
getclipboard()
```

Example:

```lua
setclipboard("PlumeRuntime")

print(getclipboard())
```

Clipboard contents are stored in memory and do not interact with the operating system clipboard.

---

### Drawing

```lua
Drawing.new(shapeType)
```

Example:

```lua
local object = Drawing.new("Square")

object.Visible = true
object.Position = {100, 100}

print(object.Visible)

object:Remove()
```

Supported properties include:

```lua
Visible
Color
Position
Remove()
```

Drawing objects are simulated and are not rendered to the screen.

---

### Console

```lua
rconsoleprint(text)
rconsoleclear()
rconsolename(title)
```

Example:

```lua
rconsolename("PlumeRuntime Console")
rconsoleprint("Runtime started\n")
```

Behavior depends on the host operating system and available console APIs.

---

## Testing

PlumeRuntime includes an integrated test suite covering the major API categories.

```lua
info("Running PlumeRuntime tests...")
```

Test categories include:

- Logging
- Executor information
- Environment handling
- Filesystem operations
- System information
- Encoding
- HTTP mocks
- Clipboard
- Metatables
- Drawing
- Console utilities

Run the test file using the Lua interpreter supported by your environment.

---

## Compatibility

The project primarily relies on standard Lua facilities:

```text
io
os
debug
table
string
```

Compatibility may vary depending on:

- Lua/Luau version
- Operating system
- Available standard libraries
- Process permissions
- Host runtime restrictions

---

## Limitations

PlumeRuntime intentionally does not provide:

- Roblox code execution
- Roblox injection
- Game manipulation
- Real executor functionality
- Real HTTP networking
- Native clipboard access
- Screen rendering
- Complete read-only table protection
- Guaranteed compatibility with every Lua implementation

This project is designed to simulate interfaces, not reproduce an actual execution environment.

---

## Intended Use Cases

PlumeRuntime is suitable for:

- Local API development
- Compatibility testing
- Mock-driven development
- Automated test environments
- Lua education
- Script prototyping
- Runtime abstraction layers
- Documentation examples
- Offline demonstrations

---

## Project Status

**Status:** Experimental / Development

The API may evolve as additional mock implementations and compatibility improvements are introduced.

---

## License

No license has been selected yet.

If you intend to distribute this project publicly, add an appropriate open-source license such as MIT, BSD-2-Clause, or Apache-2.0.

---

## Disclaimer

PlumeRuntime is an independent, simulated runtime project.

It is not affiliated with, endorsed by, or connected to Roblox Corporation.

---

## Project Motto

> **Mock the interface. Validate the behavior. Build with confidence.**
