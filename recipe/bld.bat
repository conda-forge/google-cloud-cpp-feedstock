@echo on
setlocal EnableDelayedExpansion

:: CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"
set BUILD_PREFIX="%BUILD_PREFIX:\=/%"
set SRC_DIR="%SRC_DIR:\=/%"

set DISABLED=""
:: Provided by `google-cloud-cpp-core-feedstock`.
set DISABLED=%DISABLED%,-oauth2
set DISABLED=%DISABLED%,-bigtable
set DISABLED=%DISABLED%,-iam
set DISABLED=%DISABLED%,-policytroubleshooter
set DISABLED=%DISABLED%,-pubsub
set DISABLED=%DISABLED%,-spanner
set DISABLED=%DISABLED%,-storage
:: Provided by `google-cloud-cpp-compute-feedstock`.
set DISABLED=%DISABLED%,-compute
:: Provided by `google-cloud-cpp-compute-ai-feedstock`.
set DISABLED=%DISABLED%,-aiplatform
set DISABLED=%DISABLED%,-automl
set DISABLED=%DISABLED%,-discoveryengine
set DISABLED=%DISABLED%,-dialogflow_es
set DISABLED=%DISABLED%,-dialogflow_cx
set DISABLED=%DISABLED%,-dlp
set DISABLED=%DISABLED%,-speech
set DISABLED=%DISABLED%,-texttospeech
set DISABLED=%DISABLED%,-timeseriesinsights
set DISABLED=%DISABLED%,-translate
set DISABLED=%DISABLED%,-videointelligence
set DISABLED=%DISABLED%,-vision
:: Provided by `google-cloud-cpp-bigquery-feedstock`.
set DISABLED=%DISABLED%,-bigquery
:: TODO(coryan) - pick a cutoff
set DISABLED=%DISABLED%,-monitoring
set DISABLED=%DISABLED%,-retail
set DISABLED=%DISABLED%,-appengine
set DISABLED=%DISABLED%,-sql
set DISABLED=%DISABLED%,-resourcemanager
set DISABLED=%DISABLED%,-dataproc

cmake -G "Ninja" ^
    -S . -B .build/all ^
    -DGOOGLE_CLOUD_CPP_ENABLE=__ga_libraries__%DISABLED% ^
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

cmake --build .build/all  --config Release
if %ERRORLEVEL% neq 0 exit 1
