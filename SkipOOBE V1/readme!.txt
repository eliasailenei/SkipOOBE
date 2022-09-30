This script doesn't have the Audit mode fixed! You can do the following things to fix this!

Step 1)
Add these after >> %RegFile% Echo "EnableCursorSuppression"=dword:00000000 :
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status]
>> %RegFile% Echo "AuditBoot"=dword:00000000
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status\SysprepStatus\]
>> %RegFile% Echo "CleanupState"=dword:00000007
>> %RegFile% Echo "GeneralizationState"=dword:00000007
>> %RegFile% Echo.

Step 2)
If you already used the script, then make a reg file and these contents.
.
[HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status]
"AuditBoot"=dword:00000000
.
[HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status\SysprepStatus\]
"CleanupState"=dword:00000007
"GeneralizationState"=dword:00000007
.
(Dots represent blank spaces, make sure you remove them!)
And restart!