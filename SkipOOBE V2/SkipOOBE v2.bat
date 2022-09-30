@echo off
color a
color CF
echo Welcome to SkipOOBE by Elias! Make sure you ran with admin rights!
@echo .
@echo .
echo By using this script, although skipping OOBE, you still agree with Microsoft Windows Terms and Services. If you don't, exit now! Also, I am not held responsible if ANYTHING goes wrong. This script is at very alpha stage of production so run at your own risk!
timeout /T 5
cls
color af
echo The script is now ready, make sure you ran with admin rights!
pause
@Echo On
REM ~ call :IsAdmin

call :RegExport


:RegExport
Set RegFile="%Temp%\~import.reg"

If Exist %RegFile% (
 Attrib -R -S -H %RegFile% &  Del /F /Q %RegFile%
 If Exist %RegFile% cls & Echo Could not delete file %RegFile% & Pause
)
> %RegFile% Echo Windows Registry Editor Version 5.00
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup]
>> %RegFile% Echo "CmdLine"=""
>> %RegFile% Echo "RespecializeCmdLine"=""
>> %RegFile% Echo "OOBEInProgress"=dword:00000000
>> %RegFile% Echo "SetupPhase"=dword:00000000
>> %RegFile% Echo "SetupType"=dword:00000000
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
>> %RegFile% Echo "EnableCursorSuppression"=dword:00000000
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status]
>> %RegFile% Echo "AuditBoot"=dword:00000000
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status\SysprepStatus\]
>> %RegFile% Echo "CleanupState"=dword:00000007
>> %RegFile% Echo "GeneralizationState"=dword:00000007
>> %RegFile% Echo.

Start /Wait %systemroot%\Regedit.exe /S %RegFile%
Del %RegFile%

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause  
)
Cls
@echo off
color 9
color BC
cls
echo Registry has been editied, you will no longer see OOBE!
@echo .
echo Script is ready for User Creation, DO NOT SKIP AS YOU WILL NOT BE ABLE TO LOGIN BACK AGAIN!
pause
cls
echo Do you want the account Administrator to still be active? (If your not going to make an account, select this option. If you are going to make an account select NO!)
:choice
set /P c=Y= YES N=NO A=YES WITH CUSTOM PASSWORD YOUR CHOICE:
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
if /I "%c%" EQU "A" goto :custom
goto :choice


:yes
cls
@net user administrator /active:yes
echo Done! You may exit!
pause
echo msgbox "Thanks for using my script! " > %tmp%\tmp.vbs
@wscript %tmp%\tmp.vbs
@del %tmp%\tmp.vbs
shutdown.exe /r /t 00

:no
cls
echo net user administrator /active:no> %tmp%\delete.bat
echo logoff>> %tmp%\delete.bat
echo del "%~f0">> %tmp%\delete.bat
cd C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
copy C:\Users\Administrator\AppData\Local\Temp\delete.bat
cls
set /p username="USERNAME: "
set /p password="PASSWORD: "
@net user %username% %password% /add
@net localgroup administrators %username% /add
echo Done! You may exit!
pause
echo msgbox "Please be warned! Your system will restart into Administrator account! However, it will deactivate itself. Also, if you going to use the Administrator account, delete the 'delete.bat' file in C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ or you won't get access." > %tmp%\tmp.vbs
@wscript %tmp%\tmp.vbs
@del %tmp%\tmp.vbs
shutdown.exe /r /t 00

:custom
@net user administrator /active:yes
net user administrator *
echo Done! You may exit!
pause
echo msgbox "Thanks for using my script! " > %tmp%\tmp.vbs
@wscript %tmp%\tmp.vbs
@del %tmp%\tmp.vbs
shutdown.exe /r /t 00