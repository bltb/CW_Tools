@echo off
REM Windows batch script to run Procmon for a specified amount of 
REM time and capture filestem IO events during a case backup. 
REM
REM This script uses a supplied Procmon configuration file, in order to 
REM specify the events to capture, and to exclude all filtered events
REM from the generated log file.
REM
REM Instructions:
REM
REM 1. Create a directory such as "D:\Procmon_CaseBackup" and ensure that it
REM    contains the following files:
REM      Procmon.exe
REM      PmCfg_CaseBackup.pmc (Procmon config file, including filters).
REM      run_procmon.bat (This script).
REM
REM 2. Use the Windows "at" command to schedule Windows to call this
REM    this script shortly before the case backup is due to start.
REM    For example, the following schedules the script to run at 09:35AM and
REM    allows the Procmon capture to run for up to 5 minutes (300,000 milliseconds):
REM      C:\Users\Administrator>at 09:35 D:\Procmon_CaseBackup\run_procmon.bat 300000
REM      Added a new job with job ID = 3
REM
REM 3. This script should generate the following output files:
REM      CaseBackup.pml (The Procmon output log file).
REM      CaseBackup.log (The output log file generated by this script).
REM
REM JeremyC 21/11/2014

REM Default time (in milliseconds) to let Procmon run for. 
REM This needs to cover the time it takes for the case backup to complete.
set default_expectedbackuptimemilliseconds=300000

REM The directory containing this script.
set procmoncasebackupdir=%~dp0

REM Procmon startup options and configuration file.
set PMHide= /AcceptEula /Quiet /Minimized
set PMExe="%procmoncasebackupdir%\Procmon.exe"
set PMCfg=  /LoadConfig "%procmoncasebackupdir%\PmCfg_CaseBackup.pmc"

REM Destination of the Procmon output file.
REM This file can get large (e.g. an estimated 10Gb for a case backup that runs for 7 hours).
REM Edit the following path to be a UNC one, if required, like this:
REM set PMFile= /BackingFile "\\CW1\d$\CaseBackup.pml"
set PMFile= /BackingFile "%procmoncasebackupdir%\CaseBackup.pml"

REM Our own log file for use with this script.
set LogFile="%procmoncasebackupdir%\CaseBackup.log"

goto START_OF_SCRIPT

:START_OF_FUNCTION_DEFS
REM Function to empty our script log file.
:FUNC_LOG_RESET
copy /y NUL %LogFile% >NUL
goto :eof

REM Function to log something to our script log file.
:FUNC_LOG
call :FUNC_DATE_TIME_CYGWIN
echo %curdatetime% %* >> %LogFile%
goto :eof

REM Function to generate datestamp for logging.
:FUNC_DATE_TIME
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set curdatetime=%mydate%_%mytime%
goto :eof

REM Function to generate datestamp for logging.
:FUNC_DATE_TIME_CYGWIN
for /f %%i in ('C:\Cygwin\bin\date.exe "+%%Y%%m%%d_%%H%%M%%S"') do set curdatetime=%%i
goto :eof
:END_OF_FUNCTION_DEFS

:START_OF_SCRIPT
call :FUNC_LOG_RESET

REM Determine the time that we will let Procmon run for.
set expectedbackuptimemilliseconds=%1
if "X%expectedbackuptimemilliseconds%"=="X" (
    set expectedbackuptimemilliseconds=%default_expectedbackuptimemilliseconds%
)

REM Start Procmon. This will start logging immediately.
call :FUNC_LOG Starting Procmon with output file %PMFile%
start "" %PMExe% %PMHide% %PMCfg% %PMFile%
%PMExe% /WaitForIdle
call :FUNC_LOG Procmon started

REM Wait a suitably long enough time for the backup to complete.
call :FUNC_LOG Waiting %expectedbackuptimemilliseconds% milliseconds
ping 1.1.1.1 -n 1 -w %expectedbackuptimemilliseconds% > nul

REM Terminate Procmon.
call :FUNC_LOG Terminating Procmon
%PMExe% /Terminate
call :FUNC_LOG Procmon terminated

REM Reset Procmon for future use.
call :FUNC_LOG Resetting Procmon defaults
start "" %PMExe% /PagingFile /Quiet /NoFilter /NoConnect
%PMExe% /WaitForIdle
%PMExe% /Terminate