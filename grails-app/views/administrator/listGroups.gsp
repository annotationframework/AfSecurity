<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>All Groups List - - total# ${groups.size()} - ${grailsApplication.config.af.shared.title}</title>
  	</head>
  	<body>
  		<div class="title">
  			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'groups.png',plugin:'af-security')}"/> 
  				Groups List - total# ${groups.size()}
  		</div>
		<g:render template="/administrator/listGroups" />
  	</body>
</html>