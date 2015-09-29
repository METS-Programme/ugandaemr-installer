<%@ taglib prefix="rpt" uri="/WEB-INF/view/module/reportingcompatibility/resources/reportingcompatibility.tld" %>
<br />
<table>
	<tr>
		<td colspan="2">
			<spring:message code="PatientSearch.title"/>:
			<select name="patientSearchIdValue" onChange="updateCohortColumn(this)">
				<option value=""></option>
				<rpt:forEachReportObject name="reportObject" reportObjectType="Patient Search">
					<option value="${record.reportObjectId}">${record.name}</option>
				</rpt:forEachReportObject>
			</select>			
			<i><spring:message code="general.or"/></i>
			<spring:message code="Cohort.title.endUser"/>:
			<select name="cohortIdValue" onChange="updateCohortColumn(this)">
				<option value=""></option>
				<openmrs:forEachRecord name="cohort">
					<option value="${record.cohortId}">${record.name}</option>
				</openmrs:forEachRecord>
			</select>
			<i><spring:message code="general.or"/></i>
			<spring:message code="reportingcompatibility.PatientFilter.title.endUser"/>:
			<select name="filterIdValue" onChange="updateCohortColumn(this)">
				<option value=""></option>
				<rpt:forEachReportObject name="reportObject" reportObjectType="Patient Filter">
					<option value="${record.reportObjectId}">${record.name}</option>
				</rpt:forEachReportObject>
			</select>			
		</td>
	</tr>
	<tr>
		<td><spring:message code="reportingcompatibility.DataExport.columnName"/></td>
		<td><input type="text" name="cohortName" size="30" /></td>
	</tr>
	<tr>
		<td><spring:message code="reportingcompatibility.DataExport.cohort.valueIfTrue"/></td>
		<td><input type="text" name="cohortIfTrue"/></td>
	</tr>
	<tr>
		<td><spring:message code="reportingcompatibility.DataExport.cohort.valueIfFalse"/></td>
		<td><input type="text" name="cohortIfFalse"/></td>
	</tr>
</table>
<br/>
