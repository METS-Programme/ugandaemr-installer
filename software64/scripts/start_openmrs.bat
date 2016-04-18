<<<<<<< HEAD
runas /user:Administrator
@echo off

echo Start UgandaEMR Tomcat
net start UgandaEMRTomcat

echo Start MySQL
net start MySQL

echo OpenMRS is started

pause

=======
runas /user:Administrator
@echo off

echo Start Tomcat
net start OpenmrsTomcat

echo Start MySQL
net start MySQL

echo OpenMRS is started

pause

>>>>>>> 838eb59979cd3f719611548b67f498a5821aac6d
exit