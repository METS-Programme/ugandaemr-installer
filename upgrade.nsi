;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "UgandaEMR Upgrade"
!define MUI_ICON "software/favicon.ico"
!define MUI_UNICON "software/favicon.ico"

Var SMDir ;Start menu folder
Var errorsrc
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined
!define MUI_HEADERIMAGE_BITMAP "software\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
RequestExecutionLevel admin


;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages
  !insertmacro MUI_LANGUAGE "English"
;--------------------------------

OutFile "includes\scripts\upgrade.exe"

;-------------------------Splash Screen For installer--------------------------------

Var RestoreFilePath

  XPStyle on
Function .onInit

UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
    MessageBox mb_iconstop "Administrator rights required!"
    SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
    Quit
${EndIf}
FunctionEnd

!define /date MyTIMESTAMP "%Y-%m-%d-%H%M"
;===========================================Installer Sections============================================
Section -defaultProperties
DetailPrint 'Stopping Tomcat'
nsExec::Exec 'net stop UgandaEMRTomcat' $0
DetailPrint 'Tomcat Stopped  $0'
   CopyFiles "C:\Program Files\UgandaEMR\UgandaEMRTomcat\webapps\openmrs.war" "C:\Application Data\OpenMRS\warfile\${MyTIMESTAMP}\openmrs.war"
   RMDir /r 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\webapps\openmrs'
   RMDir /r 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\temp'
   CreateDirectory 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\temp'
   RMDir /r 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\work\Catalina\localhost'
   RMDir /r 'C:\Application Data\OpenMRS\.openmrs-lib-cache'
   RMDir /r 'C:\Application Data\OpenMRS\activemq-data'
   RMDir /r 'C:\Application Data\OpenMRS\chartsearch'
   RMDir /r 'C:\Application Data\OpenMRS\lucene'
   Delete 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\webapps\openmrs.war'
SectionEnd

Section -defaultProperties32
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\.openmrs-lib-cache'
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\activemq-data'
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\chartsearch'
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\lucene'
   CopyFiles "C:\Application Data\openmrs-runtime.properties" "C:\Windows\System32\config\systemprofile\Application Data\OpenMRS"
SectionEnd

;Restore database in UgandaEMR
Section 'Upgrade War File' SecUpgradeWarFile
SectionIn RO
nsDialogs::SelectFileDialog mode initial_selection open
Pop $0
StrCpy $RestoreFilePath $0
CopyFiles $RestoreFilePath "C:\Program Files\UgandaEMR\UgandaEMRTomcat\webapps"
DetailPrint 'Starting Tomcat $0'
nsExec::Exec 'net start UgandaEMRTomcat'
DetailPrint 'Tomcat Started $0'
!define MB_OK 0x00000000
!define MB_ICONINFORMATION 0x00000040
System::Call 'USER32::MessageBox(i $hwndparent, t "UgandaEMR war file was upgraded go to browser to proceed ", t "Upgrade Completed", i ${MB_OK}|${MB_ICONINFORMATION})i'
Quit
SectionEnd

;Setting Start menu
Section -StartMenu
!insertmacro MUI_STARTMENU_WRITE_BEGIN 0 ;This macro sets $SMDir and skips to MUI_STARTMENU_WRITE_END if the "Don't create shortcuts" checkbox is checked...
CreateDirectory "$SMPrograms\$SMDir"
SetOutPath "$SMPrograms\$SMDir"
File  "includes\shortcuts\Start UgandaEMR.lnk"
File  "includes\shortcuts\Stop UgandaEMR.lnk"
File  "includes\shortcuts\Backup UgandaEMR Database.lnk"
File  "includes\shortcuts\Restore UgandaEMR Database.lnk"
File  "includes\shortcuts\Upgrade UgandaEMR War File.lnk"
File  "includes\shortcuts\Correct Database Path.lnk"
File  "includes\shortcuts\Launch Tomcat Manager.lnk"
File  "includes\shortcuts\uninstall.lnk"
File  "includes\shortcuts\Access UgandaEMR.url"
!insertmacro MUI_STARTMENU_WRITE_END
SectionEnd
;--------------------------------