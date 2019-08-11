;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "UgandaEMR Mysql Script Excecuutor"
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

OutFile "includes\scripts\mysqlscriptexcecutor.exe"

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
;===========================================Installer Sections============================================

;Restore database in UgandaEMR
Section 'Restore Database' -SecRestoreDB
SectionIn RO
nsDialogs::SelectFileDialog mode initial_selection open
Pop $0
StrCpy $RestoreFilePath $0
MessageBox MB_OK "Path to the mysql script to execute [$RestoreFilePath]"
importdbs:
      DetailPrint "SQL file import"
      ExecWait '"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql" --user=openmrs --password=openmrs --execute="source $RestoreFilePath" openmrs' $2
      StrCmp $2 1 0 endinst
	  StrCpy $errorsrc "File import error"
      Goto abortinst
      abortinst:
          DetailPrint "                         "
          DetailPrint "$\n An error occured ! $\n"
          DetailPrint "  $errorsrc              "
          DetailPrint "                         "
   endinst:
SectionEnd
;--------------------------------