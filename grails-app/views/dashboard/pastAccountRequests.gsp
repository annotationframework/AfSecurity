<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
  <head>
    <meta name="layout" content="administrator-dashboard" />
	<title>Past Account Requests List - total# ${accountRequestsTotal} :: ${grailsApplication.config.af.shared.title}</title>
  </head>
  
  <body>
  	<div class="title">
		Past Users account requests List - total# ${accountRequestsTotal}
	</div>
	<g:render template="/dashboard/pastAccountRequests" />
  </body>
</html>