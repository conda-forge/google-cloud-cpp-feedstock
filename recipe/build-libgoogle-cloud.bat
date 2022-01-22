@echo on
setlocal EnableDelayedExpansion

@REM CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"
set BUILD_PREFIX="%BUILD_PREFIX:\=/%"
set SRC_DIR="%SRC_DIR:\=/%"

cmake --build "%SRC_DIR%/build_cmake" --target install --config Release
if NOT ERRORLEVEL 0 exit /b 1

if [%PKG_NAME%] == [libgoogle-cloud] (
  del %LIBRARY_PREFIX%\lib\cmake\google_cloud_cpp*
  if NOT ERRORLEVEL 0 exit /b 1
  del %LIBRARY_PREFIX%\include\google\cloud
  if NOT ERRORLEVEL 0 exit /b 1
)
