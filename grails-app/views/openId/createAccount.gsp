<head>
<meta name='layout' content='public-layout-wide'/>
<title>Create Account</title>
<title>Link Account :: ${grailsApplication.config.af.shared.title}</title>
<style>
div.public-formbox {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
	background: #fff;
	padding: 15px;
}

.public-formbox-inner {
	width: 450px;
	border: 3px #FFCC00 solid;
	background: #fff;
	height: 140px;
}

.public-formbox-inner table {
	border: 0px;
}

td.public-formbox-title {
	
	background: #FFCC00;
	border-bottom: 1px #cc3300 solid;
	color: #000;
	padding: 0;
	padding-left: 10px;
	padding-right: 10px;
	height: 18px;
	padding-top: 10px;
	height: 20px;
}

td.public-formbox-title table {
	width: 100%;
	font-size: 16px;
	border: 0;
}

table.public-formbox-inner  td {
	border: 0;
}
</style>
</head>

<body>

<div class='body'>

<g:render template="/public/navigation" /> 

<div class="wrapper col2">
  <div id="featured_slide" >
  <div class="slider" style="border-top: 0px solid #DC143C;padding-top: 10px;" align="center">
  	<div id='public-formbox'>

			<table style="width: 600px;" class='public-formbox-inner'>
				<tr>
                    <td class="public-formbox-title" colspan="2">
                        <table>
                            <tr>
                                <td align="left">Sign Up for ${grailsApplication.config.af.shared.name} v. <g:meta name="app.version"/> </td>
                                <td align="right" class="openid-loginbox-useopenid"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
              
                <tr>
                	<td width="100px" align="center">
                	<br/><br/>
			<img src="${resource(dir: 'images/shared', file: 'face-sad.png')}"/></td><td>
                		<h4>No user was found with that OpenID</h4>
		<br/>
		<g:if test='${openId}'>
			But you can  <g:link controller="main" action='signup' style="text-decoration: underline;">sign up</g:link> and associate your OpenID with that account afterwards.<br/>
			Or if you're already a user you can <g:link action='linkAccount' style="text-decoration: underline;">link this OpenID</g:link> to your account.<br/>
			<br/>
		</g:if>
		<g:hasErrors bean="${command}">
		<div class="errors">
			<g:renderErrors bean="${command}" as="list"/>
		</div>
		</g:hasErrors>
	
                	</td>
                </tr>
                </table>

</div></div></div></div></div>
<g:render template="/shared/copyright" /> 
</body>
