<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>

<h2><spring:message code="custombranding.title"/></h2>
<br/>

<c:if test="${not empty largeLogo}">
    <div class="boxHeader">Large Logo 
        <form style="color:black; position: absolute; right: 20px; padding: 5px;" method="post" action="custombranding.form?id=largeLogo&action=reset">
            <input type="submit" value="Back to theme default" />
        </form>
    </div>
    <div class="box">
        <table>
            <tr>
                <td>
                    <div style="border: 3px black dotted;padding: 5px;">
                        <img src="${pageContext.request.contextPath}${largeLogo}" alt="" height="92px" />
                    </div>
                </td>
                <td>
                    <form id="uploadLogoForm" 
                          method="post" enctype="multipart/form-data">
                        <input size="50" type="file" name="largeLogoFile"/><br/>
                        <input type="submit" value="Replace" />
                    </form>
                </td>
            </tr>
        </table>
    </div>
    <br/>
</c:if>

<c:if test="${not empty smallLogo}">
    <div class="boxHeader">Small Logo 
        <form style="color:black; position: absolute; right: 20px; padding: 5px;" method="post" action="custombranding.form?id=smallLogo&action=reset">
            <input type="submit" value="Back to theme default" />
        </form>
    </div>
    <div class="box">
        <table>
            <tr>
                <td>
                    <div style="border: 3px black dotted;padding: 5px;">
                        <img src="${pageContext.request.contextPath}${smallLogo}" alt="" height="30px" />
                    </div>
                </td>
                <td>
                    <form id="uploadLogoForm" 
                          method="post" enctype="multipart/form-data">
                        <input size="50" type="file" name="smallLogoFile"/><br/>
                        <input type="submit" value="Replace" />
                    </form>
                </td>
            </tr>
        </table>
    </div>
    <br/>
</c:if>

<c:if test="${not empty textLogo}">                   
    <div class="boxHeader">Text Logo 
        <form style="color:black; position: absolute; right: 20px; padding: 5px;" method="post" action="custombranding.form?id=textLogo&action=reset">
            <input type="submit" value="Back to theme default" />
        </form>
    </div>
    <div class="box">
        <table>
            <tr>
                <td>
                    <div style="border: 3px black dotted;padding: 5px;">
                        <img src="${pageContext.request.contextPath}${textLogo}" alt="" height="20px" />
                    </div>
                </td>
                <td>
                    <form id="uploadLogoForm" 
                          method="post" enctype="multipart/form-data">
                        <input size="50" type="file" name="textLogoFile"/>
                        <input type="submit" value="Replace" />
                    </form>
                </td>
            </tr>
        </table>
    </div>
    <br/>
</c:if> 

<%--c:if test="${not empty orgUrl}">
    <div class="boxHeader">Organization Url
        <a style="color:black; position: absolute; right: 25px;" href="custombranding.form?id=orgUrl&action=reset">Back to theme default</a>
    </div>
    <div class="box">
        <form id="uploadLogoForm" 
              action="custombranding.form?id=orgUrl&action=upload"  
              method="post" enctype="multipart/form-data">
            <input size="50" type="text" value="${orgUrl}"  />
            <input type="submit" value="Replace" />
        </form>
    </div>
    <br/>
</c:if--%>

<%@ include file="/WEB-INF/template/footer.jsp"%>