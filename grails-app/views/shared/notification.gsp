<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
<meta name="layout" content="public-layout-wide" />
<title>Domeo Confirmation - The Annotation Toolkit</title>
</head>
<body>
	<g:render template="/public/navigation" /> 
	<div class="wrapper col3">
	  	<div id="container">
		 	<div class="innercontainer">
		 		<br/><br/>
				<table>
	      	  		<tr>
			      	  	<td align="center"><img src="${resource(dir: 'images/shared', file: 'email.png')}" width="82" height="65" alt="Domeo Toolkit " /></td>
			      	  	<td style="vertical-align:top; padding-left: 20px;">${message}</td>
	      	  		</tr>
	      		</table>  
	      		<br/><br/>  
   			</div>
   		</div>
   	</div> 
	<g:render template="/shared/copyright" plugin="af-shared"  /> 
</body>
</html>
