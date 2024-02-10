@echo on
setlocal EnableDelayedExpansion

:: Once DLLs are working, we should install the non-devel packages using
::     cmake --install .build --component google_cloud_cpp_runtime
:: and the devel packages using
::     cmake --install .build --component google_cloud_cpp_development

if [%PKG_NAME%] == [libgoogle-cloud-all] (
  @REM Nothing to do, installed by libgoogle-cloud-all-devel
) else if [%PKG_NAME%] == [libgoogle-cloud-all-devel] (
  cmake --install build
  if %ERRORLEVEL% neq 0 exit 1
) else (
  @ECHO Unknown package %PKG_NAME%
  exit 1
)
