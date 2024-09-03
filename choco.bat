@echo off
:: Elevate the script to run as Administrator
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' NEQ '0' (
    echo You need to run this script as Administrator.
    pause
    exit /b
)

:: Install OpenSSH Server
echo Installing OpenSSH Server...
powershell -Command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"

:: Start the SSH service
echo Starting SSH service...
powershell -Command "Start-Service sshd"

:: Set SSH service to start automatically on boot
echo Setting SSH service to start automatically...
powershell -Command "Set-Service -Name sshd -StartupType 'Automatic'"

:: Display current username
echo.
echo Current User:
whoami

:: Display IP Address(es)
echo.
echo IP Addresses:
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4 Address"') do echo %%a

echo.
echo OpenSSH Server installed and configured successfully!
type welcome_Temp.txt
pause

