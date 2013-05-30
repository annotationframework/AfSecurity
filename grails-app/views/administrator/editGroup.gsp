<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>Edit Group: ${item?.name} :: ${grailsApplication.config.af.shared.title}</title>
  	</head>
	<body>
		<div class="title">
			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'groups-edit.png',plugin:'af-security')}"/>
				Edit Group: ${item?.name}
		</div>
		<g:render template="/administrator/editGroup" />
	</body>
</html>