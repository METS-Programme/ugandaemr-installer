runas /user:Administrator
@echo off

echo Start UgandaEMR
net start UgandaEMRTomcat

echo Start MySQL
net start MySQL

echo UgandaEMR is started

pause

exit
=======
echo UgandaEMR is started
