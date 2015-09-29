<br />
<table>
	<tr class="conceptColumnName">
		<td><spring:message code="reportingcompatibility.DataExport.columnName"/></td>
		<td><input type="text" name="conceptColumnName" size="30" /></td>
	</tr>
	<tr class="conceptColumnModifier">
		<td><spring:message code="reportingcompatibility.DataExport.columnModifier"/></td>
		<td>
			<input type="radio" name="conceptModifier" value="any" checked="checked" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.columnModifier.any"/></span>
			<input type="radio" name="conceptModifier" value="first" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.columnModifier.first"/></span>
			<input type="radio" name="conceptModifier" value="mostRecent" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.columnModifier.mostRecent"/></span>
			<input type="radio" name="conceptModifier" value="firstNum" onclick="showNum(this)" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.columnModifier.firstNum"/></span>
			<input type="radio" name="conceptModifier" value="mostRecentNum" onclick="showNum(this)" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.columnModifier.mostRecentNum"/></span>
			<input type="text" name="conceptModifierNum" size="3" />
		</td>
	</tr>
	<tr class="conceptColumnValue">
		<td><spring:message code="reportingcompatibility.DataExport.columnValue"/></td>
		<td id="conceptSearchCell">
			<div id="conceptSearch">
				<!-- dojo search widget/popup are added here via the addNew() function -->
			</div>
		</td>
	</tr>
	<tr class="conceptColumnExtras">
		<td><spring:message code="reportingcompatibility.DataExport.conceptExtras"/></td>
		<td>
			<input type="checkbox" name="conceptExtra" value="obsDatetime" checked="checked" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.conceptExtra.obsDatetime"/></span>
			<input type="checkbox" name="conceptExtra" value="location" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.conceptExtra.location"/></span>
			<input type="checkbox" name="conceptExtra" value="comment" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.conceptExtra.comment"/></span>
			<input type="checkbox" name="conceptExtra" value="encounterType" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.conceptExtra.encounterType"/></span>
			<input type="checkbox" name="conceptExtra" value="provider" /><span onclick="this.previousSibling.click()"><spring:message code="reportingcompatibility.DataExport.conceptExtra.provider"/></span>
</table>
<br/>