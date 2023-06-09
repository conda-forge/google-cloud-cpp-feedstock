@echo on
setlocal EnableDelayedExpansion

@REM CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"
set BUILD_PREFIX="%BUILD_PREFIX:\=/%"
set SRC_DIR="%SRC_DIR:\=/%"

if [%PKG_NAME%] == [libgoogle-cloud] (
  cmake --install build --component google_cloud_cpp_runtime
  if %ERRORLEVEL% neq 0 exit 1
) else (
  cmake --install build --component google_cloud_cpp_development
  if %ERRORLEVEL% neq 0 exit 1
)
