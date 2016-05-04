@rem Backup the database including stored procedures required to run reports 


@mysqldump --port=3306 -u root --opt --routines openmrs > database.sql

@echo Database backup done close this window
@PAUSE > nul