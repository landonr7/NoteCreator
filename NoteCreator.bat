@echo off
setlocal ENABLEDELAYEDEXPANSION

:: Gets today's date without DOTW
set today=%date:~4%
set today=%today:/=-%
echo date: %today%

:: Get and set hour to an integer
set "hour=%time:~0,2%
if "%hour:~0,1%"==" " set "hour=%hour:~1,1%"

:: Time of day
set "min_sec=%time:~0,5%"
set num_time=%min_sec::=%
echo %num_time%

:: Day of the week
set "dotw=%date:~0,3%"
echo %dotw%

:: Depending on day, access certain portion of code
if "%dotw%" equ "Mon" goto MWF
if "%dotw%" equ "Tue" goto TuTh
if "%dotw%" equ "Wed" goto MWF
if "%dotw%" equ "Thu" goto TuTh
if "%dotw%" equ "Fri" goto MWF

:: Monday, Wednesday, Friday
:MWF
echo in MWF

if !num_time! geq 835 if !num_time! leq 925 (
    :: INEG
    echo ineg
    set "notes=INEGNotes"
    goto end

) else if !num_time! geq 940 if !num_time! leq 1030 (
    :: Information Retrieval
    echo ir
    set "notes=IRNotes"
    goto end

) else if !num_time! geq 1400 if !num_time! leq 1450 (
    :: Embedded Systems
    echo es
    set "notes=ESNotes"
    goto end

) else if !num_time! geq 1505 if !num_time! leq 1555 (
    :: Capstone
    echo cs
    set "notes=CSNotes"
    goto end

) else (
    :: Miscelaneous
    goto else
)

:TuTh
echo in TuTh

if !num_time! geq 1100 if !num_time! leq 1150 (
    :: Datamining
    echo dm
    set "notes=DMNotes"
    goto end

) else (
    goto else
)

:else

    echo misc
    set "notes=MISCNotes"
    goto end

:end

:: Where the text file will be
set "file_path=C:\Users\valor\Desktop\FALL2024-25\!notes!\!notes!%today%.txt"

:: Text inserted into the file
set "insert_text=!notes! %today%:"

:: Define the text file and the text to insert
if not exist "%file_path%" (

    echo File does not exist. Creating a new file...
    echo %insert_text% >> "%file_path%"

    :: Opens note in vscode
    code %file_path%

) else (

    code %file_path%

)

exit /b
exit

