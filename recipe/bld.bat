@echo on
setlocal EnableDelayedExpansion

@REM CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"
set BUILD_PREFIX="%BUILD_PREFIX:\=/%"
set SRC_DIR="%SRC_DIR:\=/%"

cmake -G "Ninja" ^
    -DBUILD_TESTING=OFF ^
    -DGOOGLE_CLOUD_CPP_ENABLE_EXAMPLES=OFF ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_MODULE_PATH="%LIBRARY_PREFIX%/lib/cmake" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DGOOGLE_CLOUD_CPP_ENABLE_WERROR=OFF ^
    -DProtobuf_PROTOC_EXECUTABLE="%BUILD_PREFIX%/bin/protoc" ^
    -S "%SRC_DIR%" -B "%SRC_DIR%/build_cmake"
if NOT ERRORLEVEL 0 exit /b 1

cmake --build "%SRC_DIR%/build_cmake" --target install --config Release
if NOT ERRORLEVEL 0 exit /b 1
