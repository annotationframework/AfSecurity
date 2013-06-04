<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
<title>Link OpenID :: ${grailsApplication.config.af.shared.title} </title>
<meta name="layout" content="public-layout-wide" />
</head>

<body>

<div>

<g:render template="/public/navigation" /> 

<div class="wrapper col2">
  <div id="featured_slide" >
   <div class="slider" style="border-top: 0px solid #DC143C;padding-top: 10px;" align="center">

	<g:render template="/public/linkOpenIdForm" plugin="af-security"/>      
</div>
</div>
</div>
</div>

<script>
(function() { document.getElementById('username').focus(); })();
</script>

	<g:render template="/shared/footer" plugin="af-shared" /> 
	<g:render template="/shared/copyright" plugin="af-shared"  /> 
</body>
