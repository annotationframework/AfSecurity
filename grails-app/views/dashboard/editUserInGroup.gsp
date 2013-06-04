<!DOCTYPE html>
<%-- by Paolo Ciccarese paolo.ciccarese@gmail.com --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>Edit ${usergroup.user.displayName} Membership in Group ${usergroup.group.name}</title>
  	</head>
	<body>
		<div class="title">Edit ${usergroup.user.displayName} Membership in Group ${usergroup.group.name}</div>
		<g:render template="editUserInGroup" />
	</body>
</html>