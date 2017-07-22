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
!define /date MyTIMESTAMP "%Y-%m-%d-%H%M%S"
 
OutFile backup.exe
CRCCheck on
XPStyle on 
 
 
Section -Main
StrCpy $1 "C:\Application Data\OpenMRS\backup\openmrs.backup.${MyTIMESTAMP}.sql"
ExpandEnvStrings $2 %COMSPEC%
Exec '"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe" "openmrs -uopenmrs -popenmrs> $1"'
ExecShell open '"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe" -uopenmrs -popenmrs openmrs> $1'
nsExec::Exec '"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe" --user=openmrs --password=openmrs openmrs> $1' $0
SectionEnd