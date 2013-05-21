<head>
<title>${grailsApplication.config.af.shared.logo.title} - Login </title>
<style type='text/css' media='screen'>

/*
div.openid-loginbox {
	width: 450px;
	margin-left: auto;
	margin-right: auto;
	background: white;
	padding: 15px;
}

.openid-loginbox-inner {
	width: 450px;
	border: 0;
}

.openid-loginbox-inner td {
	border: 0;
}


td.openid-loginbox-title {
	background: #FFAE00;
	color: white;
	border: 0;
	padding: 0;
}

td.openid-loginbox-title table {
	width: 100%;
	font-size: 18px;
	border: 0;
}

.openid-loginbox-useopenid {
	font-weight: normal;
	font-size: 14px;
}
td.openid-loginbox-title img {
	border: 0;
	vertical-align: middle;
	padding-right: 3px;
}
table.openid-loginbox-userpass {
	margin: 3px 3px 3px 8px;
}
table.openid-loginbox-userpass td {
	height: 25px;
}
input.openid-identifier {
	background: url(http://stat.livejournal.com/img/openid-inputicon.gif) no-repeat;
	background-color: #fff;
	background-position: 0 50%;
	padding-left: 18px;
}

input[type='text'],input[type='password'] {
	font-size: 16px;
	width: 310px;
}
input[type='submit'] {
	font-size: 14px;
}

td.openid-submit {
	padding: 3px;
}

*/

div.openid-loginbox {
	width: 450px;
	margin-left: auto;
	margin-right: auto;
	background: #ddd;
	padding: 15px;
	
}

.openid-loginbox-inner {
	width: 450px;
	border: 0;
	background: #fff;
	height: 140px;
	border-top-left-radius:22px;
	border-top-right-radius:22px;
	border-radius:25px;
	/*
	border-radius:25px;
	-moz-border-radius:25px;*/ /* Firefox 3.6 and earlier */
}

td.openid-loginbox-inner {
	border: 0px;
}

.openid-loginbox-inner td {
	border: 0px;
}

table.openid-loginbox-inner tbody td {
	border: 0px;
}

td.openid-loginbox-title {
	border:0;
	background: #FFCC00;
	/*
	border-bottom: 1px #cc3300 solid;
	border-top-left-radius:22px;
	border-top-right-radius:22px;
	*/
	color: #000;
	padding: 0;
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 10px;
	height: 20px;
}

td.openid-loginbox-title table {
	width: 100%;
	font-size: 18px;
	color: black;
	border:0;
}
.openid-loginbox-useopenid {
	font-weight: normal;
	font-size: 14px;
	border:0;
}
td.openid-loginbox-title img {
	border: 0;
	vertical-align: middle;
	padding-right: 3px;
}
table.openid-loginbox-userpass {
	border:0;
	height: 140px;
}
table.openid-loginbox-userpass td {
	height: 25px;
	border:0;
}
input.openid-identifier {
/*
	background: url(http://stat.livejournal.com/img/openid-inputicon.gif) no-repeat;
	background-color: #fff;
	background-position: 0 50%;
	padding-left: 18px;*/
}

input[type='text'],input[type='password'] {
	font-size: 16px;
	width: 310px;
}
input[type='submit'] {
	font-size: 14px;
}

td.openid-submit {
	padding: 3px;
}


</style>
<meta name="layout" content="example-layout" />
</head>

<body>
<g:render template="/public/navigation" /> 

<div class="wrapper col2">
  <div id="featured_slide" >
   <div class="slider" style="border-top: 0px solid #DC143C;padding-top: 10px;" align="center">
  <div id='openid-loginbox'>
	<div class='inner'>
		<g:if test='${flash.message}'>
				<div class='login_message'>${flash.message}</div>
		</g:if>
		<table class='openid-loginbox-inner' cellpadding="0" cellspacing="0">
			<tr>
				<td class="openid-loginbox-title">
					<table>
						<tr>
							<td align="left">Log in</td>
							<td align="right" class="openid-loginbox-useopenid">
								<input type="checkbox" id="toggle" checked='checked' onclick='toggleForms()'/>
								<label for='toggle'>Use OpenID</label>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
				<div id='openidLogin' style='display: none'>
					<form action='${openIdPostUrl}' method='POST' autocomplete='off' name='openIdLoginForm'>
					<table class="openid-loginbox-userpass">
						<tr>
							<td>OpenID:</td>
							<td><input type="text" name="${openidIdentifier}" class="openid-identifier"/></td>
						</tr>
						<g:if test='${persistentRememberMe}'>
						<tr>
							<td><label for='remember_me'>Remember me</label></td>
							<td>
								<input type='checkbox' name='${rememberMeParameter}' id='remember_me'/>
							</td>
						</tr>
						</g:if>
						<tr>
							<td colspan='2' class="openid-submit" align="center">
								<input type="submit" value="Log in" />
							</td>
						</tr>
					</table>
					</form>
				</div>
	
				<div id='formLogin' >
					<form action='${daoPostUrl}' method='POST' autocomplete='off' name='loginForm'>
					<table class="openid-loginbox-userpass">
						<tr>
							<td>Username:</td>
							<td><input type="text" name='j_username' id='username' class="username" /></td>
						</tr>
						<tr>
							<td>Password:</td>
							<td><input type="password" name='j_password' id='password' /></td>
						</tr>
						<tr>
							<td><label for='remember_me'>Remember me</label></td>
							<td>
								<input type='checkbox' name='${rememberMeParameter}' id='remember_me'/>
							</td>
						</tr>
						<tr>
							<td colspan='2' class="openid-submit" align="center">
								<input type="submit" value="Log in" />
							</td>
						</tr>
					</table>
					</form>
				</div>
	
				</td>
			</tr>
		</table>
	</div>
</div>
</div>
  <%-- 
	<div class="openid-loginbox">
		<g:if test='${flash.message}'>
		<div class='login_message'>${flash.message}</div>
		</g:if>
	
		<table class='openid-loginbox-inner' cellpadding="0" cellspacing="0">
			<tr>
				<td class="openid-loginbox-title">
					<table>
						<tr>
							<td align="left">Please log in:</td>
							<td align="right" class="openid-loginbox-useopenid">
								<input type="checkbox" id="toggle" checked='checked' onclick='toggleForms()'/>
								<label for='toggle'>Use OpenID</label>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
	
				<div id='openidLogin'>
					<form action='${openIdPostUrl}' method='POST' autocomplete='off' name='openIdLoginForm'>
					<table class="openid-loginbox-userpass">
						<tr>
							<td>OpenID:</td>
							<td><input type="text" name="${openidIdentifier}" class="openid-identifier"/></td>
						</tr>
						<g:if test='${persistentRememberMe}'>
						<tr>
							<td><label for='remember_me'>Remember me</label></td>
							<td>
								<input type='checkbox' name='${rememberMeParameter}' id='remember_me'/>
							</td>
						</tr>
						</g:if>
						<tr>
							<td colspan='2' class="openid-submit" align="center">
								<input type="submit" value="Log in" />
							</td>
						</tr>
					</table>
					</form>
				</div>
	
				<div id='formLogin' style='display: none'>
					<form action='${daoPostUrl}' method='POST' autocomplete='off'>
					<table class="openid-loginbox-userpass">
						<tr>
							<td>Username:</td>
							<td><input type="text" name='j_username' id='username' /></td>
						</tr>
						<tr>
							<td>Password:</td>
							<td><input type="password" name='j_password' id='password' /></td>
						</tr>
						<tr>
							<td><label for='remember_me'>Remember me</label></td>
							<td>
								<input type='checkbox' name='${rememberMeParameter}' id='remember_me'/>
							</td>
						</tr>
						<tr>
							<td colspan='2' class="openid-submit" align="center">
								<input type="submit" value="Log in" />
							</td>
						</tr>
					</table>
					</form>
				</div>
	
				</td>
			</tr>
		</table>
	</div>
	--%>
</div>
</div>
<g:render template="/shared/wide" /> 
<g:render template="/shared/footer" /> 
<g:render template="/shared/copyright" /> 

<script>

(function() { document.forms['openIdLoginForm'].elements['openid_identifier'].focus(); })();

var openid = true;

function toggleForms() {
	if (openid) {
		document.getElementById('openidLogin').style.display = 'none';
		document.getElementById('formLogin').style.display = '';
	}
	else {
		document.getElementById('openidLogin').style.display = '';
		document.getElementById('formLogin').style.display = 'none';
	}
	openid = !openid;
}
</script>
</body>
