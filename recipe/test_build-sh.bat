:: in test environment, we don't have PREFIX/SRC_DIR set; work around it
set "PREFIX=%BUILD_PREFIX%\..\_test_env"
set "SRC_DIR=%BUILD_PREFIX%\..\test_tmp"
:: default build-script being used is "build.sh"
call %LIBRARY_BIN%\run_autotools_clang_conda_build.bat
if %ERRORLEVEL% neq 0 exit 1
