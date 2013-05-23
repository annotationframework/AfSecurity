<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>
<%@ page import="org.mindinformatics.ann.framework.module.security.users.User" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.users.UserRole" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultUsersRoles" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.UserUtils" %>

<html>
<head>
   	<meta name="layout" content="administrator-dashboard" />
	<title>:: Users <g:if test="${role!=null}">(with Role: ${role.label})</g:if> List - total# ${usersTotal}</title>
</head>
<body>
	<g:render template="/administrator/listUsers" />
</body>
</html>