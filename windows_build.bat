@echo on
setlocal

REM Ensure MinGW is in PATH (adjust if installed elsewhere)
set PATH=C:\tools\mingw64\bin;C:\tools\mingw32\bin;C:\ProgramData\chocolatey\bin;%PATH%

REM Compile resource file if present
if exist 3dco.rc (
    windres 3dco.rc -O coff -o 3dco.res
)

REM Run g++ with explicit file expansion
g++ -std=c++17 -g -mwindows -Wall ^
  src\glad.c ^
  src\imgui\*.cpp ^
  src\*.cpp ^
  -I include -I src\imgui ^
  -o 3dco.exe ^
  3dco.res ^
  -L lib ^
  -lSDL2 -lglfw3 -lmingw32 -lgdi32 -lopengl32

REM Check for errors
if %ERRORLEVEL% neq 0 (
    echo Build failed with error %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

echo Build succeeded!
endlocal
