:: in test environment, we don't have PREFIX/SRC_DIR set; work around it
set "PREFIX=%BUILD_PREFIX%\..\_test_env"
set "SRC_DIR=%BUILD_PREFIX%\..\test_tmp"
call %LIBRARY_BIN%\run_autotools_clang_conda_build.bat build_subpackage.sh
if %ERRORLEVEL% neq 0 exit 1
