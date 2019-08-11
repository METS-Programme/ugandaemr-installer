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
 
OutFile "includes\scripts\cleaner.exe"
CRCCheck on
XPStyle on 

;Remove previous settings
Section -defaultProperties
DetailPrint 'Stopping Tomcat'
nsExec::Exec 'net stop UgandaEMRTomcat' $0
DetailPrint 'Tomcat Stopped  $0'
   RMDir /r 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\webapps\openmrs'
   RMDir /r 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\temp'
   CreateDirectory 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\temp'
   RMDir /r 'C:\Program Files\UgandaEMR\UgandaEMRTomcat\work\Catalina\localhost'
   RMDir /r 'C:\Application Data\OpenMRS\.openmrs-lib-cache'
   RMDir /r 'C:\Application Data\OpenMRS\activemq-data'
   RMDir /r 'C:\Application Data\OpenMRS\chartsearch'
   RMDir /r 'C:\Application Data\OpenMRS\lucene'
SectionEnd

Section -defaultProperties32
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\.openmrs-lib-cache'
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\activemq-data'
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\chartsearch'
   RMDir /r 'C:\Windows\System32\config\systemprofile\Application Data\OpenMRS\lucene'
SectionEnd

;Restore war file in UgandaEMR
Section 'Start Tomcat' SecStartTomcat
SectionIn RO
DetailPrint 'Starting Tomcat $0'
nsExec::Exec 'net start UgandaEMRTomcat'
DetailPrint 'Tomcat Started $0'
Quit
SectionEnd