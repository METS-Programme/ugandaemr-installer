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
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined
!insertmacro MUI_PAGE_INSTFILES

!define MUI_HEADERIMAGE_BITMAP "software\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
RequestExecutionLevel admin
!define /date MyTIMESTAMP "%Y-%m-%d-%H%M"
 
OutFile "includes\scripts\backup.exe"
CRCCheck on
XPStyle on 

;This sections backup the database 
Section -Main
!define MB_OK 0x00000000
!define MB_ICONINFORMATION 0x00000040
StrCpy $1 '"C:\Application Data\OpenMRS\backup\openmrs.backup.${MyTIMESTAMP}.sql"'
FileOpen $4 "$DESKTOP\backup.bat" w
FileWrite $4 "mysqldump openmrs -uopenmrs -popenmrs>$1"
FileClose $4
DetailPrint 'Starting to backup openmrs database'
nsExec::Exec '"$DESKTOP\backup.bat"' $0
ExecWait '"$0" /C "$DESKTOP\backup.bat"'
Delete '$DESKTOP\backup.bat'
DetailPrint 'Database Backup Completed Backup file link $1'
System::Call 'USER32::MessageBox(i $hwndparent, t $1, t "Backup Completed", i ${MB_OK}|${MB_ICONINFORMATION})i'
Quit
SectionEnd