@echo on
setlocal

set "TEST_ROOT=%~dp0"
set "RECIPE_DIR=%TEST_ROOT%"
set "TEST_WORK_DIR=%CD%"
set "SMOKE_ROOT=%TEST_WORK_DIR%\autotools-smoke-%RANDOM%-%RANDOM%"
set "SRC_DIR=%SMOKE_ROOT%\src"
set "BUILD_PREFIX=%PREFIX%"
set "LIBRARY_PREFIX=%SMOKE_ROOT%\prefix"
set "LIBRARY_BIN=%LIBRARY_PREFIX%\bin"
set "LIBRARY_INC=%LIBRARY_PREFIX%\include"
set "LIBRARY_LIB=%LIBRARY_PREFIX%\lib"
set "PKG_NAME=autotools_smoke"
set "REMOVE_LIB_PREFIX=no"

mkdir "%SRC_DIR%"
if errorlevel 1 exit /b 1
xcopy /E /I /Y "%TEST_ROOT%project\*" "%SRC_DIR%\"
if errorlevel 1 exit /b 1

pushd "%SRC_DIR%"
if errorlevel 1 exit /b 1
call "%BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat" smoke-build.sh
set "BUILD_RESULT=%ERRORLEVEL%"
popd
if not "%BUILD_RESULT%"=="0" exit /b %BUILD_RESULT%

set "SMOKE_DLL="
for %%F in ("%LIBRARY_BIN%\*autotools_smoke*.dll") do if exist "%%~fF" set "SMOKE_DLL=%%~fF"
if not defined SMOKE_DLL exit /b 1
if not exist "%LIBRARY_LIB%\autotools_smoke.lib" exit /b 1
if not exist "%LIBRARY_LIB%\autotools_smoke_static.lib" exit /b 1
if exist "%LIBRARY_LIB%\autotools_smoke.dll.lib" exit /b 1

set "PATH=%LIBRARY_BIN%;%PATH%"
"%LIBRARY_BIN%\autotools-smoke.exe"
if errorlevel 1 exit /b 1

call %CC% /nologo /MD /I"%LIBRARY_INC%" "%TEST_ROOT%installed-consumer.c" /link /LIBPATH:"%LIBRARY_LIB%" autotools_smoke.lib /OUT:"%SMOKE_ROOT%\installed-consumer.exe"
if errorlevel 1 exit /b 1
dumpbin /imports "%SMOKE_ROOT%\installed-consumer.exe" | findstr /I /C:"autotools_smoke-0.dll"
if errorlevel 1 exit /b 1
"%SMOKE_ROOT%\installed-consumer.exe"
if errorlevel 1 exit /b 1

if /I "%target_platform%"=="win-arm64" (
    dumpbin /headers "%LIBRARY_BIN%\autotools-smoke.exe" | findstr /I /C:"AA64 machine (ARM64)"
    if errorlevel 1 exit /b 1
    dumpbin /headers "%SMOKE_DLL%" | findstr /I /C:"AA64 machine (ARM64)"
    if errorlevel 1 exit /b 1
    dumpbin /headers "%SMOKE_ROOT%\installed-consumer.exe" | findstr /I /C:"AA64 machine (ARM64)"
    if errorlevel 1 exit /b 1
) else (
    dumpbin /headers "%LIBRARY_BIN%\autotools-smoke.exe" | findstr /I /C:"8664 machine (x64)"
    if errorlevel 1 exit /b 1
    dumpbin /headers "%SMOKE_DLL%" | findstr /I /C:"8664 machine (x64)"
    if errorlevel 1 exit /b 1
    dumpbin /headers "%SMOKE_ROOT%\installed-consumer.exe" | findstr /I /C:"8664 machine (x64)"
    if errorlevel 1 exit /b 1
)

rmdir /S /Q "%SMOKE_ROOT%"
if errorlevel 1 exit /b 1

endlocal
