@echo on
setlocal EnableDelayedExpansion

@REM CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"

set LIBRARY=storage
if [%PKG_NAME%] == [google-cloud-cpp-full] (
  set LIBRARY=kms
)

cmake -GNinja ^
    -S google/cloud/%LIBRARY%/quickstart -B .build/quickstart ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_MODULE_PATH="%LIBRARY_PREFIX%/lib/cmake"
if %ERRORLEVEL% neq 0 exit 1

cmake --build .build/quickstart --config Release
if %ERRORLEVEL% neq 0 exit 1
