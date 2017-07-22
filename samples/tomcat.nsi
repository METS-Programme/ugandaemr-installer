;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "Uganda EMR"
!define JavaRegKey 'HKLM "Software\JavaSoft\Java Runtime Environment" ""'
!define MUI_ICON "software/favicon.ico"
!define MUI_UNICON "software/favicon.ico"

Var SMDir ;Start menu folder
Var errorsrc
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined


!define MUI_HEADERIMAGE_BITMAP "software64\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
!define TOMCATDIR "C:\Program Files\UgandaEMR\UgandaEMRTomcat\"
RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages
  !insertmacro MUI_PAGE_LICENSE "includes\license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_STARTMENU 0 $SMDir
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

OutFile "tomcat.exe"

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
	# the plugins dir is automatically deleted when the installer exits
	InitPluginsDir
	File /oname=$PLUGINSDIR\splash.bmp "includes\splash.bmp"
     advsplash::show 5000 600 400 -1 $PLUGINSDIR\splash

	Pop $0 ; $0 has '1' if the user closed the splash screen early,
			; '0' if everything closed normally, and '-1' if some error occurred.
FunctionEnd
;===========================================Installer Sections============================================

Var IPAddressControl
Var IPADR
 
Function MyDialogePre
  nsDialogs::Create 1018
  Pop $R0
 
  ${If} $R0 == error
    Abort
  ${EndIf}
 
  ; This would more appropriately be called in .onGUIInit
  ${NSD_InitIPaddress}
  Pop $0
 
  IntCmp $0 0 0 +3 +3
  MessageBox MB_OK "Something went wrong while initializing the IPaddress control"
  Abort
 
  ${NSD_CreateLabel} 0u 0 50% 10% "Input IP address:"
  Pop $0
  ${NSD_CreateIPaddress} 5% 90% 30% 12u ""
  Pop $IPAddressControl
  ${NSD_SetText} $IPAddressControl "192.168.1.1"
  Pop $IPAddressControl
  
  nsDialogs::Show
FunctionEnd
 
Function MyDialogeAfter
  ${NSD_GetText} $IPAddressControl $IPADR
  MessageBox MB_OK "IP=$IPADR: Here you could save IP-address to file..."
FunctionEnd
 
Function MyNextPage
  MessageBox MB_OK "(IP=$IPADR): Do some more stuff here..."
FunctionEnd
 
Section
SectionEnd