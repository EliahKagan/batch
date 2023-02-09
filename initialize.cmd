@echo off

setlocal

set "conf_path=.inherited-configuration"
set "script_uuid=7d63c880-c89c-4bc4-b440-57e134bf08d9"

set "script_name=%~nx0"
set "temp_path=%TEMP%\%script_uuid%"

call :delete %conf_path%

:: If the host clones the repo Windows-style, have the container play along.
call :push_in core.autocrlf

:: Usually these are automatically set in the container, but not always.
call :push_in user.name
call :push_in user.email

:: Test with a nonexistent git configuration variable. (FIXME: Remove this.)
call :push_in user.avatar

call :delete %temp_path%

goto done

:msg
    echo/%script_name%: %* >&2
    exit /b

:delete
    if exist "%*" (
        del "%*"
    )
    exit /b

:push_in
    setlocal
    set "name=%1"

    for /f "usebackq delims=" %%a in (`git config "%name%"`) do (
        set "value=%%a"
    )

    if %ERRORLEVEL% EQU 0 (
        call :msg carrying in: %name%=%value%
        echo/%name% %value% >>"%conf_path%"
    ) else (
        call :msg skipping: %name%
    )

    exit /b

:done
