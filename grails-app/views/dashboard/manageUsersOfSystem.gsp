<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>Manage Users of System: ${system.name} :: ${grailsApplication.config.af.shared.title}</title>
  	</head>

  	<body>
  		<div class="title">Manage Users of System: ${system.name} - total# ${usersTotal}</div>
		<g:render template="manageUsersOfSystem" />
  	</body>
</html>