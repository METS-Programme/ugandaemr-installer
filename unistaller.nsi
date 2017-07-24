# Included files
!include MUI2.nsh

;--------------------------------
;Defines
!include "MUI2.nsh"
!include "Registry.nsh"
!include "Sections.nsh"

Name "UgandaEMR Uninstall"
!define MUI_ICON "software/favicon.ico"
!define MUI_UNICON "software/favicon.ico"

!define /date MYTIMESTAMP "%d-%m-%Y% H.%M.%S"

Var SMDir ;Start menu folder
!insertmacro MUI_PAGE_COMPONENTS
;!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MY Program" ;Default, name is used if not defined
!insertmacro MUI_PAGE_INSTFILES

!define MUI_HEADERIMAGE_BITMAP "software\logo.bmp"
!define MUI_HEADERIMAGE_RIGHT
RequestExecutionLevel admin
!define INSTDIR "$DESKTOP\UgandaEMR\backups"
 
OutFile uninstaller.exe
CRCCheck on
XPStyle on 


 ;Backup openmrs database
Section "backup openmrs" SecBackupOpenmrs
DetailPrint 'backingup database files exit code = $0'
StrCpy $1 '$DESKTOP\UgandaEMR\backups\openmrs_backup.OutFile.${MYTIMESTAMP}.sql'
ExpandEnvStrings $2 %COMSPEC%
nsExec::Exec "C:\Program Files\UgandaEMR\scripts\backup.exe" $0
nsExec::Exec 'C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql  -uroot -popenmrs "drop database openmrs"'
SectionEnd
 
 ;Delete Desktop icons
Section "Delete Shortcut" SecDeleteDesktopIcons
SetShellVarContext all
DetailPrint 'Deleting shortcuts exit code = $0'
Delete  "$DESKTOP\Start OpenMRS.lnk"
Delete  "$DESKTOP\Stop OpenMRS.lnk"
Delete  "$DESKTOP\Access OpenMRS.url"

Delete "$SMPROGRAMS\UgandaEMR\Start OpenMRS.lnk"
Delete "$SMPROGRAMS\UgandaEMR\Stop OpenMRS.lnk"
Delete "$SMPROGRAMS\UgandaEMR\Backup OpenMRS.lnk"
RMDir /r "$SMPROGRAMS\UgandaEMR"
SectionEnd


Section "Unistall UgandaEMRTomcat" SecUnistallTomcat
DetailPrint 'Unistalling tomcat exit code = $0'
nsExec::Exec '"C:\Program Files\UgandaEMR\UgandaEMRTomcat\Uninstall.exe" -ServiceName="UgandaEMRTomcat"'
DetailPrint 'Done Uninstalling Tomcat'
SectionEnd

Section "Unistall HeidiSQL" SecUnistallHeidiSQL
DetailPrint 'HeidiSQL exit code = $0'
nsExec::Exec "C:\Program Files\HeidiSQL\unins000.exe"
DetailPrint 'Done Uninstalling HeidiSQL'
SectionEnd

Section "Uninstall Registers" -SecUnistallReg
  ; remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UgandaEMR"
  DeleteRegKey HKLM "SOFTWARE\UgandaEMR"
  
  # now delete installed file
  RMDir /r "$PROGRAMFILES\UgandaEMR\scripts"
 
  ; remove files and directories
  Delete "C:\Program Files\UgandaEMR\uninstaller.exe"  ; MUST REMOVE UNINSTALLER, too
SectionEnd