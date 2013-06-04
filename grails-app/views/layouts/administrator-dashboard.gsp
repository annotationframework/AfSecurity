<!doctype html>

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
	<g:render template="/shared/meta" />
	<g:render template="/shared/title-and-icon" />
	
	<link rel="stylesheet" href="${resource(dir: 'css/shared', file: 'reset.css', plugin: 'af-shared')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css/shared', file: 'logo.css', plugin: 'af-shared')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css/shared/business', file: 'full-screen.css', plugin: 'af-shared')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css/dashboard', file: 'navigation-menu.css')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css/dashboard', file: 'dashboard-main.css')}" type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css/dashboard', file: 'two-columns-layout.css')}" type="text/css">

	<g:javascript library="jquery"/>

	<g:layoutHead/>
	<r:layoutResources />
</head>
<body>
	<g:render template="/shared/administration" />
	<br/><br/>

	<div class="wrapper col3">
 		<div id="homecontent">
	 		<div id="contentwrapper">
				<div id="contentcolumn">
					<div class="innertube">
						<g:layoutBody/>
					</div>
				</div>
			</div>
 			<div id="leftcolumn">
 				<sec:access expression="hasRole('ROLE_ADMIN')">
  					<g:render template="/administrator/administratorMenu" />
  				</sec:access>
  				<sec:ifNotGranted roles="ROLE_ADMIN">
  					<sec:access expression="hasRole('ROLE_MANAGER')">
	  					<g:render template="/manager/managerMenu" />
	  				</sec:access>
  				</sec:ifNotGranted>
  				<sec:ifNotGranted roles="ROLE_ADMIN, ROLE_MANAGER">
					<g:render template="/user/userMenu" />
				</sec:ifNotGranted>
  			</div>
  			
  		</div>
  	</div>
	<g:render plugin="af-security"  template="/shared/copyright" /> 
	<g:render template="/shared/scripts" />
</body>