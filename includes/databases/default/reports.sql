set foreign_key_checks=0;
DELETE FROM reporting_report_design_resource;
DELETE FROM reporting_report_design;
DELETE FROM global_property WHERE property LIKE 'reporting.reportManager%';
DELETE FROM serialized_object WHERE type LIKE 'org.openmrs.module.reporting.report%';
set foreign_key_checks=1;