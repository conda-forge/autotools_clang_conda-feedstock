IF "%1"=="" (
  set "BUILDSCRIPT=build.sh"
) else (
  set "BUILDSCRIPT=%1"
)
copy "%RECIPE_DIR%\%BUILDSCRIPT%" .
copy "%LIBRARY_BIN%\create_def.sh" .
copy "%LIBRARY_BIN%\conda_build_wrapper.sh" .
set MSYSTEM=MINGW%ARCH%
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1

FOR /F "delims=" %%i in ('cygpath.exe -u "%LIBRARY_PREFIX%"') DO set "NEW_PREFIX=%%i"
:: fallback in case LIBRARY_PREFIX wasn't set (or resolvable) directly
IF "%NEW_PREFIX%"=="/" (
    FOR /F "delims=" %%i in ('cygpath.exe -u "%PREFIX%"') DO set "PREFIX=%%i/Library"
) else (
    set "PREFIX=%NEW_PREFIX%"
)
FOR /F "delims=" %%i in ('cygpath.exe -u "%BUILD_PREFIX%"') DO set "BUILD_PREFIX=%%i"
FOR /F "delims=" %%i in ('cygpath.exe -u "%SRC_DIR%"') DO set "SRC_DIR=%%i"
FOR /F "delims=" %%i in ('cygpath.exe -u "%RECIPE_DIR%"') DO set "RECIPE_DIR=%%i"

bash -lce "./conda_build_wrapper.sh %BUILDSCRIPT%"
if %ERRORLEVEL% neq 0 exit 1
