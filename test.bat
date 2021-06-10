setlocal EnableDelayedExpansion

set "tests="
for /F "tokens=4" %%a in ('type Dockerfile ^| find "AS test_"') do set "tests=!tests! %%a"

for %%a in ( !tests! ) do (
    docker build --no-cache --progress=plain --target %%a -t metacall/tests:%%a . || (
        echo Test %%a failed. Abort.
        exit /B 1
    )
)

for %%a in ( !tests! ) do (
    docker rmi metacall/tests:%%a
)

echo All tests passed.
