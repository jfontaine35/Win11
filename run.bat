@echo off

::# elevate with native shell by AveYo
>nul reg add hkcu\software\classes\.Admin\shell\runas\command /f /ve /d "cmd /x /d /r set \"f0=%%2\"& call \"%%2\" %%3"& set _= %*
>nul fltmc|| if "%f0%" neq "%~f0" (cd.>"%temp%\runas.Admin" & start "%~n0" /high "%temp%\runas.Admin" "%~f0" "%_:"=""%" & exit /b)
title Debloat - A bloatware removal tool made in batch by Cramaboule
cls & echo ======================
echo Remove dirt in Start Menu and do some tweaks
echo ======================& echo.
for /f %%a in ('REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount /s /k /f placeholdertilecollection') do (reg delete %%a\current /VA /F 2> nul)
REG add HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f 2> nul
:: Show file extensions
REG add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v "HideFileExt" /t REG_DWORD /d 0 /f 2> nul
REG add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve >nul
taskkill /f /im explorer.exe & start explorer.exe 2> nul

echo ======================
echo Install Ninite apps
echo ======================
start Ninite.exe
echo.
echo ======================
echo Changing Menu...
echo ====================== & echo.

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v "TaskbarAl" /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v "TaskbarMn" /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

echo.
echo ======================
echo Install winget
echo ====================== & echo.

::installing dependies
powershell -command "$ProgressPreference = 'SilentlyContinue' ; Get-AppxPackage -allusers *WindowsStore* | Remove-AppxPackage -allusers ; Invoke-WebRequest -Uri  https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile .\Microsoft.VCLibs.x64.14.00.Desktop.appx  ; Invoke-WebRequest -Uri  https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3 -OutFile .\microsoft.ui.xaml.2.7.3.nupkg.zip  ; Expand-Archive -Path .\microsoft.ui.xaml.2.7.3.nupkg.zip -Force ; Add-AppXPackage -Path .\microsoft.ui.xaml.2.7.3.nupkg\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx; Add-AppXPackage -Path .\Microsoft.VCLibs.x64.14.00.Desktop.appx ; Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile .\MicrosoftDesktopAppInstaller_8wekyb3d8bbwe.msixbundle ; Add-AppXPackage -Path .\MicrosoftDesktopAppInstaller_8wekyb3d8bbwe.msixbundle" 2> nul

cls & echo ======================
echo Insall packages.Please Wait...
echo ====================== & echo.
:: Sometimes it is not installed
:: Screen Capture
winget install --id 9MZ95KL8MR0L --accept-source-agreements --silent --accept-package-agreements
::Paint
winget install --id 9PCFS5B6T72H --accept-source-agreements --silent --accept-package-agreements
::Calulator
winget install --id 9WZDNCRFHVN5 --accept-source-agreements --silent --accept-package-agreements
::Photo
winget install --id 9WZDNCRFJBH4 --accept-source-agreements --silent --accept-package-agreements
::Notepad
winget install --id 9MSMLRH6LZF3 --accept-source-agreements --silent --accept-package-agreements
::Office 365
winget install --id Microsoft.Office --accept-source-agreements --silent --accept-package-agreements
::Anydesk
winget install --id Anydesk --accept-source-agreements --silent --accept-package-agreements
::Java SDK 
winget install --id Oracle.JDK.18 --accept-source-agreements --silent --accept-package-agreements
::Java JRE 
winget install --id Oracle.JavaRuntimeEnvironment --accept-source-agreements --silent --accept-package-agreements
::KeepassXC
winget install -e --id KeePassXCTeam.KeePassXC

cls & echo ======================
echo Remove packages first stage. Please Wait...
echo ====================== & echo.

:: echo OneDrive
:: TASKKILL /f /im OneDrive.exe 2>nul
:: %systemroot%\System32\OneDriveSetup.exe /uninstall 2> nul
:: %systemroot%\SysWOW64\OneDriveSetup.exe /uninstall 2> nul
powershell -command "(\"Microsoft.549981C3F5F10\", \"Microsoft.MicrosoftEdge.Stable\", \"Clipchamp.Clipchamp\", \"Microsoft.MicrosoftSolitaireCollection\", \"Microsoft.BingNews\", \"Microsoft.BingWeather\", \"Microsoft.GamingApp\", \"Microsoft.GetHelp\", \"Microsoft.Getstarted\", \"Microsoft.HEVCVideoExtension\", \"Microsoft.MicrosoftOfficeHub\", \"Microsoft.People\", \"Microsoft.PowerAutomateDesktop\", \"Microsoft.RawImageExtension\", \"Microsoft.Todos\", \"Microsoft.VP9VideoExtensions\", \"Microsoft.WebMediaExtensions\", \"Microsoft.WindowsAlarms\", \"Microsoft.WindowsCamera\", \"Microsoft.windowscommunicationsapps\", \"Microsoft.WindowsFeedbackHub\", \"Microsoft.WindowsMaps\", \"Microsoft.WindowsSoundRecorder\", \"Microsoft.WindowsTerminal\", \"Microsoft.Xbox.TCUI\", \"Microsoft.XboxGameOverlay\", \"Microsoft.XboxGamingOverlay\", \"Microsoft.XboxIdentityProvider\", \"Microsoft.XboxSpeechToTextOverlay\", \"Microsoft.YourPhone\", \"Microsoft.ZuneMusic\", \"Microsoft.ZuneVideo\", \"MicrosoftCorporationII.QuickAssist\", \"MicrosoftWindows.Client.WebExperience\", \"MicrosoftTeams\", \"Microsoft.LanguageExperiencePackfr-FR\", \"MicrosoftCorporationII.MicrosoftFamily\", \"Microsoft.MicrosoftStickyNotes\").ForEach{write-host $_ ; Get-AppxPackage -AllUsers -Name $_ | Remove-AppxPackage -AllUsers ; Get-AppxProvisionedPackage -online | where-object PackageName -like $_ | Remove-AppxProvisionedPackage -online}" 2> nul
powershell -command "Install-Module -Name PSWindowsUpdate -force"
powershell -command "Set-ExecutionPolicy RemoteSigned  -force"

cls & echo ======================
echo Windows Update. Please Wait...
echo ====================== & echo.
powershell -command "Get-WindowsUpdate -Install -AcceptAll"

cls & echo ======================
echo Remove packages segond stage. Please Wait...
echo ====================== & echo.
winget -v
echo.
::Cortana
winget uninstall cortana --accept-source-agreements --silent

::Skype
winget uninstall skype --accept-source-agreements --silent

::Camera
winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe --accept-source-agreements --silent

::Sketch
::winget uninstall Microsoft.ScreenSketch_8wekyb3d8bbwe --accept-source-agreements --silent

::Xbox Applications
winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe --accept-source-agreements --silent

::Groove Music
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe --accept-source-agreements --silent

::Feedback Hub
winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe --accept-source-agreements --silent

::Microsoft-Tips...
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe --accept-source-agreements --silent

::3D Viewer
winget uninstall 9NBLGGH42THS --accept-source-agreements --silent

:: 3D Builder
winget uninstall Microsoft.3DBuilder_8wekyb3d8bbwe --accept-source-agreements --silent

::MS Solitaire
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe --accept-source-agreements --silent

::Paint-3D
winget uninstall 9NBLGGH5FV99 --accept-source-agreements --silent

::Weather 
winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe --accept-source-agreements --silent

::Mail / Calendar
winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe --accept-source-agreements --silent

::Your Phone
winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe --accept-source-agreements --silent

::People
winget uninstall Microsoft.People_8wekyb3d8bbwe --accept-source-agreements --silent

::MS Pay 
winget uninstall Microsoft.Wallet_8wekyb3d8bbwe --accept-source-agreements --silent

::MS Maps
winget uninstall Microsoft.WindowsMaps_8wekyb3d8bbwe --accept-source-agreements --silent

::OneNote
winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe --accept-source-agreements --silent

::MS Office
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe --accept-source-agreements --silent

::Voice Recorder
winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe --accept-source-agreements --silent

::Movies & TV
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe --accept-source-agreements --silent

::Mixed Reality-Portal
winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe --accept-source-agreements --silent

::Sticky Notes...
winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe --accept-source-agreements --silent

::Get Help
winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe --accept-source-agreements --silent

::OneDrive
:: winget uninstall Microsoft.OneDrive --accept-source-agreements --silent

::Calculator
:: winget uninstall Microsoft.WindowsCalculator_8wekyb3d8bbwe --accept-source-agreements --silent


::Windows 11 Bloatware
:: Messages opérateur Windows
winget uninstall Microsoft.Messaging_8wekyb3d8bbwe --accept-source-agreements --silent
:: print 3D
winget uninstall Microsoft.Print3D_8wekyb3d8bbwe --accept-source-agreements --silent
:: One Connect
winget uninstall Microsoft.OneConnect_8wekyb3d8bbwe --accept-source-agreements --silent																   
::Microsoft TO Do
winget uninstall Microsoft.Todos_8wekyb3d8bbwe --accept-source-agreements --silent
::Power Automate
winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe --accept-source-agreements --silent
::Bing News
winget uninstall Microsoft.BingNews_8wekyb3d8bbwe --accept-source-agreements --silent
::Microsoft Teams
winget uninstall MicrosoftTeams_8wekyb3d8bbwe --accept-source-agreements --silent
::Microsoft Family
winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe --accept-source-agreements --silent
::Quick Assist
winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe --accept-source-agreements --silent
::Third-Party Preinstalled bloat
winget uninstall disney+ --accept-source-agreements --silent
winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt --accept-source-agreements --silent
::WhatsApp
winget uninstall 5319275A.WhatsAppDesktop_cv1g1gvanyjgm --accept-source-agreements --silent
::Spotify Music
winget uninstall SpotifyAB.SpotifyMusic_zpdnekdrzrea0 --accept-source-agreements --silent
::Microsoft Store
winget uninstall Microsoft.WindowsStore_8wekyb3d8bbwe --accept-source-agreements --silent
:: Other stuff
winget uninstall Microsoft.HEVCVideoExtension_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.LanguageExperiencePackfr-FR_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.RawImageExtension_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.StorePurchaseApp_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.VP9VideoExtensions_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.WebMediaExtensions_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.WindowsAlarms_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall MicrosoftWindows.Client.WebExperiencecw5n1h2txyewy --accept-source-agreements --silent
:: PC Health tool
winget uninstall {6A2A8076-135F-4F55-BB02-DED67C8C6934} --accept-source-agreements --silent
:: Microsoft Update Health Tool
winget uninstall {80F1AF52-7AC0-42A3-9AF0-689BFB271D1D} --accept-source-agreements --silent
:: Microsoft Teams
:: winget uninstall  Microsoft.Teams --accept-source-agreements --silent
start "C:\Program Files\BCUninstaller\win-x64\StoreAppHelper.exe /uninstall MicrosoftTeams_23034.1300.1846.7680_x64__8wekyb3d8bbwe"




cls
:: CHOICE /c YN /M "Do you want to run Clean Manager"
:: if %ERRORLEVEL% == 1 ()
CALL :sub_Clean

CHOICE /c YN /M "Do you want to reboot now"
if %ERRORLEVEL% == 1 (shutdown -r -f -t 00)

cls & echo Done. Thank you for using this tool. ==== Reboot is recommended ====& echo. 
pause
exit

:sub_Clean
echo Cleanning, Please Wait...
for /f "delims=" %%a in ('REG QUERY HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches /s /k /f *') do (
	REG add "%%a" /v "StateFlags0005 " /t REG_DWORD /d 2 /f >nul 2>&1 )
CleanMgr.exe /sagerun:5
exit /B
