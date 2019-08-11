REM This Script is the Setup that enables the fingerprint device to connect to UgandaEMR 
REM server IP is the IP where UgandaEMR has been installed when on same server please dont change
REM ServerName is the openmrs name. this may not need changing w you are using UgandaEMR
REM socketPort is the the port which the fingerptint connector runs it should be the same as the one in the ugandaemrfingerprint.socketIPAddress

set serverIP="localhost"
set serverName="openmrs"
set socketPort="8084"
set serverMysqlUsername="openmrs"
set serverMysqlPassword="openmrs"

start java -jar fingerprint-0.1.1.jar --spring.datasource.url=jdbc:mysql://%serverIP%/%serverName% --server.port=%socketPort% --spring.datasource.username=%serverMysqlUsername% --spring.datasource.password=%serverMysqlPassword%