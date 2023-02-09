@echo off

setlocal
set script_name=%~nx0
set conf_path=.inherited-configuration

if exist %conf_path% (
    del %conf_path%
)

:: If the host clones the repo Windows-style, have the container play along.
call :push_in core.autocrlf

:: Usually these are automatically set in the container, but not always.
call :push_in user.name
call :push_in user.email

:goto done

:msg
    echo %script_name%: %* >&2
    exit /b

:push_in
    set name=%1

    for /f "delims=" %%a in ('git config %name%') do (
        set value=%%a
    )

    if %ERRORLEVEL% EQU 0 (
        call :msg carrying in: %name%=%value%
        echo %name% %value% >>%conf_path%
    ) else (
        call :msg skipping: %name%
    )

    exit /b

:done
