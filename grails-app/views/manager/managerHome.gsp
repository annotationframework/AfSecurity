<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
	<meta name="layout" content="manager-dashboard" />
	<title>Home :: ${grailsApplication.config.af.shared.title}</title>
</head>
<body>
	<div class="title">
		Welcome ${loggedUser.displayName}
	</div>
	<br/>This is your management dashboard.
</body>
</html>