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
	
	
	<g:render template="/shared/scripts" />
    
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
  				<g:render template="/administrator/administratorMenu" />
  			</div>
  			
  		</div>
  	</div>
	
	<g:render template="/shared/copyright" plugin="af-shared" /> 
</body>