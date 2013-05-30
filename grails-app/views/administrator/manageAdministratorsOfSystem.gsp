<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>Manage Administrators of System: ${system.name} :: ${grailsApplication.config.af.shared.title}</title>
  	</head>

  	<body>
  		<div class="title">Manage Administrators of System: ${system.name} - total# ${administratorsCount}</div>
		<g:render template="/administrator/manageAdministratorsOfSystem" />
  	</body>
</html>