@echo off
:: ============================================================
::  Setup_VulnReportTask.bat
::  Run ONCE as Administrator to register the scheduled task
:: ============================================================

set SCRIPT_PATH=C:\SecurityReports\NetworkVulnerabilityReport.ps1
set TASK_NAME=NetworkVulnerabilityReport

if not exist "C:\SecurityReports" mkdir "C:\SecurityReports"
copy /Y "%~dp0NetworkVulnerabilityReport.ps1" "%SCRIPT_PATH%"

schtasks /Create /TN "%TASK_NAME%" ^
  /TR "powershell.exe -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File \"%SCRIPT_PATH%\"" ^
  /SC DAILY /ST 08:00 ^
  /RU SYSTEM ^
  /RL HIGHEST ^
  /F

if %errorlevel%==0 (
    echo.
    echo  [OK]  Task registered. Runs daily at 08:00.
    echo        Reports saved to: C:\SecurityReports\
    echo.
) else (
    echo.
    echo  [ERR] Failed. Make sure you right-clicked and chose Run as Administrator.
    echo.
)

pause
