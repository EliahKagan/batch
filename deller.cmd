@echo off

set "name=foo   bar"
echo name: %name%
call :delete %name%
goto done

:delete
    if exist "%*" (
        del "%*"
    )
    exit /b

:done
