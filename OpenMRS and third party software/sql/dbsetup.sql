--
--
--
--
--

--
-- 	Create the user "test" which is used by OpenMRS to communicate with
-- 	the database and grant all appropriate permissions to it.
--

CREATE USER test@localhost IDENTIFIED BY "test";
GRANT ALL ON openmrs.* TO 'test'@'localhost';

use openmrs

-- set @birt_dir = "c:\\OpenMRS\\birt-runtime-2_2_0";
-- set @tomcat_dir = "c:\\OpenMRS\\apache-tomcat-5.5.25";
-- set @appdata = "c:\\users\\splinter\\AppData\\Roaming\\OpenMRS";
-- set @tomcat_port = 8080;
-- set @mysql_port = 3307;

--
--	Delete the properties which point to the cabextract and lcab binaries on
--	unix.  Windows already provides these services as part of the base OS.
--

delete from global_property where property = 'formentry.lcab_location';
delete from global_property where property = 'formentry.cabextract_location';

update global_property set property_value = concat(@birt_dir,'\\ReportEngine') where property = 'birt.birtHome';
update global_property set property_value = concat('http://127.0.0.1:',@tomcat_port,'/openmrs') where property = 'formentry.infopath_server_url';
update global_property set property_value = concat(@appdata,'\\reports\\datasets') where property = 'birt.datasetDir'; 
update global_property set property_value = concat(@tomcat_dir,'\\logs') where property = 'birt.loggingDir';
update global_property set property_value = concat(@appdata,'\\reports\\output') where property = 'birt.outputDir';
update global_property set property_value = concat(@appdata,'\\reports') where property = 'birt.reportDir';
update global_property set property_value = concat(@appdata,'\\reports\\output\\ReportOutput.pdf') where property = 'birt.reportOutputFile';
update global_property set property_value = concat(@appdata,'\\reports\\output\\ReportPreview.pdf') where property = 'birt.reportPreviewFile';
update global_property set property_value = concat(@appdata,'\\formentry\\forms') where property = 'formentry.infopath_output_dir';

--
-- Set the OpenMRS Express:HIV concept source / implementation ID
--

delete from concept_source;
insert into concept_source (concept_source_id,name,description,hl7_code,creator,voided,date_created) values (1,'OpenMRS Express:HIV','OpenMRS Express:HIV implements the generic WHO care and monitoring guidelines for HIV and AIDS.','OMRSXPRSHIV100', 1,0,'2010-02-01 12:00:00');
delete from global_property where property = 'implementation_id';
insert into global_property (property,property_value) values ('implementation_id','<implementationId id="1" implementationId="OMRSXPRSHIV100">
   <passphrase id="2"><![CDATA[Do androids dream of electric sheep]]></passphrase>
   <description id="3"><![CDATA[OpenMRS Express:HIV implements the generic WHO care and monitoring guidelines for HIV and AIDS.]]></description>
   <name id="4"><![CDATA[OpenMRS Express:HIV]]></name>
</implementationId>');

