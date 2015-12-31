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
!insertmacro MUI_PAGE_COMPONENTS
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined
!insertmacro MUI_PAGE_STARTMENU 0 $SMDir
!insertmacro MUI_PAGE_INSTFILES

!define MUI_HEADERIMAGE_BITMAP "software\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
RequestExecutionLevel admin




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




;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages


  !insertmacro MUI_PAGE_LICENSE "includes\license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
  !insertmacro MUI_LANGUAGE "English"
;--------------------------------

InstallDir "$PROGRAMFILES\UgandaEMR"	;This line creates a default location for the installation. Note that $PROGRAMFILES is a constant value provided by NSIS
DirText "OpenMrs will install in this directory"
!define instDirectory "$PROGRAMFILES\UgandaEMR"

;Installer Sections
;Installing Java
Section 'Java Runtime' SecJava

  SetOutPath '$TEMP'
  SetOverwrite on
  File 'software\jdk-7u79.exe'
  ExecWait '"$TEMP\jdk-7u79.exe"' $0
  DetailPrint '..Java Runtime Setup exit code = $0'
  Delete '$TEMP\jdk-7u79.exe'
  ; include for some of the windows messages defines
  !include "winmessages.nsh"
  ; HKLM (all users) vs HKCU (current user) defines
  !define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
  !define env_hkcu 'HKCU "Environment"'
  ; set variable
  WriteRegStr ${env_hklm} JAVA_HOME "$PROGRAMFILES\Java\jdk1.7.0_79"
  WriteRegStr ${env_hklm} JRE_HOME "$PROGRAMFILES\Java\jre7"
  ; make sure windows knows about the change
  WriteRegStr ${env_hkcu} JAVA_HOME "$PROGRAMFILES\Java\jdk1.7.0_79"
  WriteRegStr ${env_hkcu} JRE_HOME "$PROGRAMFILES\Java\jre7"
  WriteRegStr ${env_hkcu} Path "%JAVA_HOME%\bin;"
  WriteRegDWORD  HKCU "SOFTWARE\JavaSoft\Java Update\Policy" 'EnableJavaUpdate' 0
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
SectionEnd


;Installing Mysql
Section 'Mysql 5.5.28' SecMysql
  SetOutPath '$TEMP'
  SetOverwrite on
  ;MySQL Server 5.5
  File 'software\mysql-5.5.28.msi'
  ExecWait '"msiexec" /i "$TEMP\mysql-5.5.28.msi" /promptrestart /passive' $0 ;
  DetailPrint '..Mysql 5.5.28 Setup exit code = $0'
  Delete '$TEMP\mysql-5.5.28.msi'
  ExecWait '$PROGRAMFILES\MYSQL\MySQL Server 5.5\bin\mysqlinstanceconfig.exe' $0
SectionEnd

;Installing Tomcat
Section 'Tomcat 7.0.65' SecTomcat

SetOutPath "$PROGRAMFILES\UgandaEMR\"
File /r "software\apache-tomcat"
SectionEnd


;Setting up tomcat config
Section 'Configure Tomcat' -SecTomcatConfig
SetOutPath "$DESKTOP"
File  "software\TomcatConfig.cmd"
SectionEnd


;Installing war file
Section 'OpenMRS 1.9.9' SecOpenMRS
SetOutPath "$PROGRAMFILES\UgandaEMR\apache-tomcat\webapps"
File   "software\openmrs.war"
SectionEnd

;Copying Scripts
Section 'Scripts' SecScripts
SetOutPath "$PROGRAMFILES\UgandaEMR"
File /r "software\scripts"
SectionEnd


;Setting Start menu
Section -StartMenu
!insertmacro MUI_STARTMENU_WRITE_BEGIN 0 ;This macro sets $SMDir and skips to MUI_STARTMENU_WRITE_END if the "Don't create shortcuts" checkbox is checked...
CreateDirectory "$SMPrograms\$SMDir"
SetOutPath "$SMPrograms\$SMDir"
File  "software\Start OpenMRS.lnk"
File  "software\Stop OpenMRS.lnk"
File  "software\Backup OpenMRS.lnk"
!insertmacro MUI_STARTMENU_WRITE_END
SectionEnd


;Create Desktop icons
Section "Desktop Shortcut" SecDesktopIcons
SetOutPath "$DESKTOP\"
File  "software\Start OpenMRS.lnk"
File  "software\Stop OpenMRS.lnk"
SectionEnd
;--------------------------------
;--------------------------------