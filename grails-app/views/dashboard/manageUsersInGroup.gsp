<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>Manage Users in Group: ${group.name} :: ${grailsApplication.config.af.shared.title}</title>
  	</head>

  	<body>
  		<div class="title">Manage Users in Group: ${group.name} - total# ${groupusers.size()}</div>
		<g:render template="/administrator/manageUsersInGroup" />
  	</body>
</html>