@echo on
setlocal EnableDelayedExpansion

@REM CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"
set BUILD_PREFIX="%BUILD_PREFIX:\=/%"
set SRC_DIR="%SRC_DIR:\=/%"

cmake -G "Ninja" ^
    -S . -B build ^
    -DGOOGLE_CLOUD_CPP_ENABLE=__ga_libraries__ ^
    -DBUILD_TESTING=OFF ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_MODULE_PATH="%LIBRARY_PREFIX%/lib/cmake" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DGOOGLE_CLOUD_CPP_ENABLE_EXAMPLES=OFF ^
    -DGOOGLE_CLOUD_CPP_ENABLE_WERROR=OFF
if %ERRORLEVEL% neq 0 exit 1

cmake --build build --config Release
if %ERRORLEVEL% neq 0 exit 1
