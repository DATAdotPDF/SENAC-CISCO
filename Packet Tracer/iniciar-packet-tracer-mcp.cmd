@echo off
rem Inicia o servidor packet-tracer-mcp (MCP em :39001, ponte da extensao em :54321)
set SRC=%USERPROFILE%\.codex\.chatgpt-projects\g-p-6aa1e5c8ba9081919b43d867cb7f9406\packet-tracer-mcp-src
cd /d "%SRC%\source"
"%SRC%\runtime\bun\bun-windows-x64\bun.exe" run src/index.ts
