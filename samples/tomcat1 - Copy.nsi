;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "Uganda EMR"
!define JavaRegKey 'HKLM "Software\JavaSoft\Java Runtime Environment" ""'
!define MUI_ICON "..\software/favicon.ico"
!define MUI_UNICON "..\software/favicon.ico"

Var SMDir ;Start menu folder
Var errorsrc
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined


!define MUI_HEADERIMAGE_BITMAP "software64\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
!define TOMCATDIR "C:\Program Files\UgandaEMR\UgandaEMRTomcat\"
RequestExecutionLevel highest

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

InstallDir "C:\Program Files\UgandaEMR"	;This line creates a default location for the installation. Note that C:\Program Files is a constant value provided by NSIS
DirText "OpenMrs will install in this directory"
!define instDirectory "C:\Program Files\UgandaEMR"

OutFile "path.exe"

;-------------------------Splash Screen For installer--------------------------------
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
;===========================================Installer Sections============================================

Var IPAddressControl
Var IPADR
 

 
;Installing Tomcat
Section -secTomcat

!define MB_OK 0x00000000
!define MB_ICONINFORMATION 0x00000040
FileOpen $4 "$DESKTOP\configuemr.bat" w
FileWrite $4 'mkdir "C:\Windows\System32\config\systemprofile\Application Data\OpenMRS"'
FileWrite $4 '$\nxcopy /s /e /y "C:\Application Data\OpenMRS" "C:\Windows\System32\config\systemprofile\Application Data\OpenMRS"$\n PAUSE'
FileClose $4
DetailPrint 'Starting to backup openmrs database'

ExpandEnvStrings $0 %COMSPEC%
ExecShell "open" "$DESKTOP\configuemr.bat"
Delete '$DESKTOP\cconfiguemr.bat'
SectionEnd