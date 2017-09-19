;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "Uganda EMR"
!define JavaRegKey 'HKLM "Software\JavaSoft\Java Runtime Environment" ""'
!define MUI_ICON "software/favicon.ico"
!define MUI_UNICON "software/favicon.ico"


Var mysqlUserName
Var mysqlPassword
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
Var RestoreFilePath

OutFile "ugandaemr_2.0_upgrade64bit.exe"

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

!define /date MyTIMESTAMP "%Y-%m-%d-%H%M"
;===========================================Installer Sections============================================

;Remove previous settings
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

;Installing Java
Section 'Java Runtime' SecJava
  SectionIn RO
  SetOutPath '$TEMP'
  SetOverwrite on
  File 'software64\jdk-8u131.exe'
  ExecWait '"$TEMP\jdk-8u131.exe"' $0
  DetailPrint '..Java Runtime Setup exit code = $0'
  Delete '$TEMP\jdk-8u131.exe'
  ; include for some of the windows messages defines
  !include "winmessages.nsh"
  ; HKLM (all users) vs HKCU (current user) defines
  !define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
  !define env_hkcu 'HKCU "Environment"'
  ; set variable
  WriteRegStr ${env_hklm} JAVA_HOME "C:\Program Files\Java\jdk1.8.0_131"
  WriteRegStr ${env_hklm} JRE_HOME "C:\Program Files\Java\jre1.8.0_131"
  ; make sure windows knows about the change
  WriteRegStr ${env_hkcu} JAVA_HOME "C:\Program Files\Java\jdk1.8.0_131"
  WriteRegStr ${env_hkcu} JRE_HOME "C:\Program Files\Java\jre1.8.0_131"
  WriteRegStr ${env_hkcu} Path "%JAVA_HOME%\bin;"
  WriteRegDWORD  HKCU "SOFTWARE\JavaSoft\Java Update\Policy" 'EnableJavaUpdate' 0
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
SectionEnd

;Copying Scripts
Section -scripts
SetOutPath "C:\Program Files\UgandaEMR"
File /r "includes\scripts"
SectionEnd

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

Section -defaultDatabase
    DetailPrint "Running import"

StrCmp $createdb 1 importdbs
 SetOutPath "$DESKTOP\"
 File 'includes\databases\default\concept_dictonary_ref.sql'
  DetailPrint '..Add default database exit code = $0'
   importdbs:
      DetailPrint "SQL file import"
      ExecWait '"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql" --user=openmrs --password=openmrs --execute="source $DESKTOP\concept_dictonary_ref.sql" openmrs' $2
      StrCmp $2 1 0 endinst
      StrCpy $errorsrc "File import error"
      Goto abortinst

      abortinst:
          DetailPrint "                         "
          DetailPrint "$\n An error occured ! $\n"
          DetailPrint "  $errorsrc              "
          DetailPrint "                         "

   endinst:
   Delete '$DESKTOP\concept_dictonary_ref.sql'
SectionEnd

;Change tomcat to run on Java 8
Section  -secTomcat
SectionIn RO
nsExec::Exec '"C:\Program Files\UgandaEMR\UgandaEMRTomcat\bin\UgandaEMRTomcat" //IS//UgandaEMRTomcat --Jvm="C:\Program Files\Java\jre1.8.0_131\bin\server\jvm.dll"'
SectionEnd

;Restore war file in UgandaEMR
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

;--------------------------------