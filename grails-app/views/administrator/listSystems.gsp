<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>All Systems List</title>
  	</head>
  	<body>
  		<div class="title">
  			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'computer.png',plugin:'users-module')}"/> 
  				System List - total# ${systems.size()}
  		</div>
		<g:render template="/administrator/listSystems" />
  	</body>
</html>