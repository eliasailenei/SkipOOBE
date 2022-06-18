@echo off
echo Welcome to SkipOOBE by Elias! Make sure you ran with admin rights!
echo .
echo .
echo By using this script, although skipping OOBE, you still agree with Microsoft Windows Terms and Services. If you don't, exit 
timeout /T 5
cls
echo The script is now ready, make sure you ran with admin rights!
pause
REM ~ call :IsAdmin

call :RegExport


:RegExport
Set RegFile="%Temp%\~bgtfbub.tmp"

> %RegFile% Echo Windows Registry Editor Version 5.00
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup]
>> %RegFile% Echo "CmdLine"=hex(1):00
>> %RegFile% Echo "RespecializeCmdLine"=hex(1):00
>> %RegFile% Echo "OOBEInProgress"=dword:00000000
>> %RegFile% Echo "SetupPhase"=dword:00000000
>> %RegFile% Echo "SetupType"=dword:00000000
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
>> %RegFile% Echo "EnableCursorSuppression"=dword:00000000

Start /Wait %systemroot%\Regedit.exe /S %RegFile%
Del %RegFile%

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo An Error Occured! Please make sure you right click and press Run As Administrator for the script to work! 
 Pause
)
Cls


echo Registry has been editied, you will no longer see OOBE!
echo .
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
net user administrator /active:yes
echo Done! You may exit!
pause
echo msgbox "Thanks for using my script! See more at my github! https://github.com/eliasailenei" > %tmp%\tmp.vbs
wscript %tmp%\tmp.vbs
del %tmp%\tmp.vbs
exit

:no
cls
set /p username="USERNAME: "
set /p password="PASSWORD: "
net user %username% %password% /add
net localgroup administrators %username% /add
echo Done! You may exit!
pause
echo msgbox "Thanks for using my script! See more at my github! https://github.com/eliasailenei" > %tmp%\tmp.vbs
wscript %tmp%\tmp.vbs
del %tmp%\tmp.vbs
exit

:custom
net user administrator /active:yes
net user administrator *
echo Done! You may exit!
pause
echo msgbox "Thanks for using my script! See more at my github! https://github.com/eliasailenei" > %tmp%\tmp.vbs
wscript %tmp%\tmp.vbs
del %tmp%\tmp.vbs
exit
