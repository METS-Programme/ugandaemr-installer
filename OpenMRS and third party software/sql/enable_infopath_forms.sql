--
--
--	OpenMRS Express Infopath 2003 form management
--	
--	This script enables the Infopath 2003 forms in the OpenMRS Express
--	Database.
--


use openmrs;
--
--  	Remove the Infopath 2003 forms
-- 
update form set retired=0, retired_by=null,date_retired=null,retired_reason=null where name like '%nfopath 2003%';