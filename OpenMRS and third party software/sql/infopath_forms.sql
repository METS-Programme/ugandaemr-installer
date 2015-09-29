--
--
--	OpenMRS Express Infopath 2003 form management
--	
--	This script disables the Infopath 2003 forms in the OpenMRS Express
--	Database.
--


use openmrs;
--
--  	Disable the Infopath 2003 forms
-- 
update form set retired=1, retired_by=1,date_retired=curdate(),retired_reason='DEPRECATED' where name like '%nfopath 2003%';