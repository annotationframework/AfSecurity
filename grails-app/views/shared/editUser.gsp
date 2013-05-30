<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
	    <meta name="layout" content="administrator-dashboard" />
	    <title>Edit User: ${item?.firstName} ${item?.lastName} 
	    	<g:if test="${item?.displayName?.length()>0}">(${item.displayName})</g:if> 
	    	:: ${grailsApplication.config.af.shared.title}
	    </title>
  	</head>

	<body>
		<div class="title">
			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'user-edit.png',plugin:'users-module')}"/>
				Edit User: ${item.displayName}
		</div>
		<table class="simpleTableNoBorder">
			<tr>
				<td valign="top"><g:render template="/shared/editUser" /></td>
			</tr>
		</table>
	</body>
</html>