@echo off

goto end

:greet
echo Hello, %1!
exit /b

:end
call :greet Alice
call :greet Bob
