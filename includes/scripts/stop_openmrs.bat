runas /user:Administrator
@echo off

echo Stop UgandaEMR Tomcat
net stop UgandaEMRTomcat

echo Stop Mysql
net stop MySQL

echo UgandaEMR is stopped

pause
=======

exit