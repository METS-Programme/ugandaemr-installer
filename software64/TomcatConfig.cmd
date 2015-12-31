runas /user:Administrator

cd C:\Program Files\UgandaEMR\apache-tomcat\bin

service.bat install

( del /q /f "%~f0" >nul 2>&1 & exit /b 0  )