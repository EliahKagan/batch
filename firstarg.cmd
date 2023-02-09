@echo off

call :echo_first foo bar
call :echo_first 'foo bar'
call :echo_first "foo bar"

:echo_first
    echo/%1
    exit /b

:done
