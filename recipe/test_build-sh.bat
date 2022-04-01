:: in test environment, we don't have %BUILD_PREFIX% available like for
:: the example in the description of meta.yaml; adapt accordingly
call %LIBRARY_BIN%\run_autotools_clang_conda_build.bat
if %ERRORLEVEL% neq 0 exit 1
