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
) else if [%PKG_NAME] == [libgoogle-cloud-full] (
  @rem cmake --install build_full --component google_cloud_cpp_runtime
  if %ERRORLEVEL% neq 0 exit 1
) else if [%PKG_NAME] == [google-cloud-cpp-full] (
  @rem cmake --install build_full --component google_cloud_cpp_development
  cmake --install build_full
  if %ERRORLEVEL% neq 0 exit 1
)
