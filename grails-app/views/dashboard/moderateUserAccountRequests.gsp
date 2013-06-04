<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  <head>
    <meta name="layout" content="administrator-dashboard" />
	<title>Users account requests List :: ${grailsApplication.config.af.shared.title}</title>
  </head>
  
  <body>
  	<div class="title">
		User account requests List - total# ${accountRequestsTotal}
	</div>
	<g:render template="/dashboard/moderateAccountRequests" />
  </body>
</html>