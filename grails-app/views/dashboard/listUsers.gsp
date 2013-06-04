<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>
<%@ page import="org.mindinformatics.ann.framework.module.security.users.User" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.users.UserRole" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultUsersRoles" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.UserUtils" %>

<html>
<head>
	<meta name="layout" content="administrator-dashboard" />
	<title>All Users List<g:if test="${role!=null}">(with Role: ${role.label})</g:if> - total# ${usersTotal} :: ${grailsApplication.config.af.shared.title}</title>
</head>
<body>
	<div class="title">
		<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'user.png')}"/> Users <g:if test="${role!=null}">(with Role: ${role.label})</g:if> List - total# ${usersTotal}
	</div>
	<sec:access expression="hasRole('ROLE_ADMIN')">
		<g:render template="/administrator/listUsers" />
	</sec:access>
	<sec:ifNotGranted roles="ROLE_ADMIN">
		<sec:access expression="hasRole('ROLE_MANAGER')">
			<g:render template="/manager/listUsers" />
		</sec:access>
	</sec:ifNotGranted>
	<sec:ifNotGranted roles="ROLE_ADMIN, ROLE_MANAGER">
		---
	</sec:ifNotGranted>
</body>
</html>