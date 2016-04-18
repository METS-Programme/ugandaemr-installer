<<<<<<< HEAD
runas /user:Administrator
@echo off 
cls 
echo ========================================== 
echo MySQL Server - Installation - v.17/03/2014 
echo ========================================== 
echo . 
echo . 
rem ------------------------------------------------ 
echo Installing. Wait ... 
msiexec /i "mysql-5.5.28-win32.msi" /qn 
echo Done. 
rem ------------------------------------------------ 
echo . 
echo . 
rem ------------------------------------------------ 
if "%PROCESSOR_ARCHITECTURE%" == "x86" (
echo Configurating. Waiting ... 
cd "C:\Program Files\MySQL\MySQL Server 5.5\bin\" 
mysqlinstanceconfig.exe -i -q ServiceName=MySQL CurrentRootPassword=root RootPassword= ServerType=SERVER DatabaseType=INODB Port=3306 Charset=utf8 
echo Done. 
rem ------------------------------------------------ 
echo . 
echo . 
rem ------------------------------------------------ 
echo Creating access to user. Waiting ... 
cd "C:\Program Files\MySQL\MySQL Server 5.5\bin\" 
mysql -uroot -pmypassword --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost WITH GRANT OPTION;" 
mysql -uroot -pmypassword --execute="FLUSH PRIVILEGES;" 
echo Done. 
rem ------------------------------------------------ 
) else (

echo Configurating. Waiting ... 
cd "C:\Program Files (x86)\MySQL\MySQL Server 5.5\bin\" 
mysqlinstanceconfig.exe -i -q ServiceName=MySQL CurrentRootPassword=root RootPassword= ServerType=SERVER DatabaseType=INODB Port=3306 Charset=utf8 
echo Done. 
rem ------------------------------------------------ 
echo . 
echo . 
rem ------------------------------------------------ 
echo Creating access to user. Waiting ... 
cd "C:\Program Files (x86)\MySQL\MySQL Server 5.5\bin\" 
mysql -uroot -pmypassword --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost WITH GRANT OPTION;" 
mysql -uroot -pmypassword --execute="FLUSH PRIVILEGES;" 
echo Done. 
rem ------------------------------------------------ 
)

echo . 
echo . 
echo Installation ready. 
echo . 
echo . 
=======
runas /user:Administrator
@echo off 
cls 
echo ========================================== 
echo MySQL Server - Installation - v.17/03/2014 
echo ========================================== 
echo . 
echo . 
rem ------------------------------------------------ 
echo Installing. Wait ... 
msiexec /i "mysql-5.5.28-win32.msi" /qn 
echo Done. 
rem ------------------------------------------------ 
echo . 
echo . 
rem ------------------------------------------------ 
if "%PROCESSOR_ARCHITECTURE%" == "x86" (
echo Configurating. Waiting ... 
cd "C:\Program Files\MySQL\MySQL Server 5.5\bin\" 
mysqlinstanceconfig.exe -i -q ServiceName=MySQL CurrentRootPassword=root RootPassword= ServerType=SERVER DatabaseType=INODB Port=3306 Charset=utf8 
echo Done. 
rem ------------------------------------------------ 
echo . 
echo . 
rem ------------------------------------------------ 
echo Creating access to user. Waiting ... 
cd "C:\Program Files\MySQL\MySQL Server 5.5\bin\" 
mysql -uroot -pmypassword --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost WITH GRANT OPTION;" 
mysql -uroot -pmypassword --execute="FLUSH PRIVILEGES;" 
echo Done. 
rem ------------------------------------------------ 
) else (

echo Configurating. Waiting ... 
cd "C:\Program Files (x86)\MySQL\MySQL Server 5.5\bin\" 
mysqlinstanceconfig.exe -i -q ServiceName=MySQL CurrentRootPassword=root RootPassword= ServerType=SERVER DatabaseType=INODB Port=3306 Charset=utf8 
echo Done. 
rem ------------------------------------------------ 
echo . 
echo . 
rem ------------------------------------------------ 
echo Creating access to user. Waiting ... 
cd "C:\Program Files (x86)\MySQL\MySQL Server 5.5\bin\" 
mysql -uroot -pmypassword --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost WITH GRANT OPTION;" 
mysql -uroot -pmypassword --execute="FLUSH PRIVILEGES;" 
echo Done. 
rem ------------------------------------------------ 
)

echo . 
echo . 
echo Installation ready. 
echo . 
echo . 
>>>>>>> 838eb59979cd3f719611548b67f498a5821aac6d
pause