:: This bat file can be used to renew Resharper C# and Resharper C++ every time it runs out
:: It most likely works for all Jetbrains tools, however, I did not test this.
:: I was not able to find the original author for the reg key and the folders that needs to be deleted so if that is you feel free to reach out for credit

@echo off 
setlocal enableDelayedExpansion

:confirm
echo Did you stop all Jetbrains services?
echo Jetbrains toolbox AND any other tool using it such as Rider, Visual Studio, ...
set /p "userInput= (Y/YES): "

set "userInput=!userInput:~0,1!" & set "userInput=!userInput:~0,1!%userInput:~1%!"
set "userInput=!userInput:~0,1!%userInput:~1%" & set "userInput=!userInput:~0,1!%userInput:~1%"
for %%a in (y yes) do (
    if /i "!userInput!"=="%%a" (
        echo Continuing...
        goto continue
    )
)

echo Please make sure that all services are stopped, otherwise it may not work.
goto confirm

:continue

REM Delete eval folder with licence key and options.xml which contains a reference to it
for %%I in ("WebStorm", "IntelliJ", "CLion", "Rider", "GoLand", "PhpStorm", "Resharper", "PyCharm") do (
    for /d %%a in ("%USERPROFILE%\.%%I*") do (
        rd /s /q "%%a/config/eval"
        del /q "%%a\config\options\other.xml"
    )
)

reg delete "HKEY_CURRENT_USER\Software\JavaSoft" /f

REM Change device identifiers
set "hex="
set "len=12"
set "chars=0123456789ABCDEF"
set "char=-"
set "inputFile[0]=%appdata%\JetBrains\PermanentPackageCheckerId"
set "inputFile[1]=%appdata%\JetBrains\PermanentDeviceId"
set "inputFile[2]=%appdata%\JetBrains\PermanentUserId"


set i=0
:loop
if defined inputFile[%i%] (
    set file=!inputFile[%i%]!

	set "tempFile=!file!.tmp"

	for /f "delims=" %%a in (!file!) do (
		set "line=%%a"

		:: Find the last occurrence of the character
		for /l %%i in (0,1,1023) do (
			set "charPos=%%i"
			if "!line:~%%i!"=="" goto replace
			if "!line:~%%i,1!"=="%char%" set "lastPos=%%i"
		)

		:replace
		set "beforeChar=!line:~0,%lastPos%!"
		
		call :random
		
		set "newLine=!beforeChar!!char!!hex!"
		echo !newLine!>>"%tempFile%"
	)

	move /Y "%tempFile%" "!file!" >nul
	echo Fixed !file!
	
    set /a i+=1
    goto :loop
)
goto :exit


:random
set "hex="
for /l %%i in (1,1,%len%) do (
    for /f "tokens=*" %%n in ('powershell -NoLogo -NoProfile -Command Get-Random -Minimum -0 -Maximum 15') do set "rnd=%%~n"
    call set "hex=!hex!%%chars:~!rnd!,1%%"
)
exit /b

:exit
pause