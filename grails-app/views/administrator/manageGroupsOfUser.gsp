<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  <head>
    <meta name="layout" content="administrator-dashboard" />
  </head>

  <body>
  	<div class="title">
  		<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'groups.png',plugin:'users-module')}"/> 
  			Groups for ${user.displayName} - total# ${usergroups.size()}
  	</div>
	<g:render template="/administrator/manageGroupsOfUser" />
  </body>
</html>