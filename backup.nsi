# Included files
!include MUI2.nsh
!include InstallOptions.nsh

;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "Uganda EMR Backup"
!define MUI_ICON "software/favicon.ico"
!define MUI_UNICON "software/favicon.ico"

Var SMDir ;Start menu folder
!insertmacro MUI_PAGE_COMPONENTS
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined
!insertmacro MUI_PAGE_INSTFILES

!define MUI_HEADERIMAGE_BITMAP "software\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
RequestExecutionLevel admin
!define instDirectory "$PROGRAMFILES\UgandaEMR\backups"
 
OutFile backup.exe
CRCCheck on
XPStyle on 
 
 
Section -Main
StrCpy $1 "$instDirectory\openmrs.sql"
ExpandEnvStrings $2 %COMSPEC%
ExecDos::exec /NOUNLOAD '"$2" /C "mysqldump" --user=root --password=yourname openmrs > $1' $0
SectionEnd