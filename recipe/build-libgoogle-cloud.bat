@echo on
setlocal EnableDelayedExpansion

@REM CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"
set BUILD_PREFIX="%BUILD_PREFIX:\=/%"
set SRC_DIR="%SRC_DIR:\=/%"

if [%PKG_NAME%] == [libgoogle-cloud] (
  @rem cmake --install build_cmake --component google_cloud_cpp_runtime
  if %ERRORLEVEL% neq 0 exit 1
) else if [%PKG_NAME] == [google-cloud-cpp] (
  @rem cmake --install build_cmake --component google_cloud_cpp_development
  cmake --install build
  if %ERRORLEVEL% neq 0 exit 1
) else (
  cmake -G "Ninja" ^
    -S . -B build_full ^
    -DGOOGLE_CLOUD_CPP_ENABLE=kms ^
    -DGOOGLE_CLOUD_CPP_USE_INSTALLED_COMMON=ON ^
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

  cmake --build build_full --config Release
  if %ERRORLEVEL% neq 0 exit 1

  cmake --install build_full
  if %ERRORLEVEL% neq 0 exit 1
)
