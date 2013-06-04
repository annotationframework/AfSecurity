<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>
<!-- DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" -->
<!-- The HTML 4.01 Transitional DOCTYPE declaration-->
<!-- above set at the top of the file will set     -->
<!-- the browser's rendering engine into           -->
<!-- "Quirks Mode". Replacing this declaration     -->
<!-- with a "Standards Mode" doctype is supported, -->
<!-- but may lead to some differences in layout.   -->

<html>
  <head>
	<meta name="layout" content="administrator-dashboard" />
	<title>Add Users to Group: ${group.name} :: ${grailsApplication.config.af.shared.title}</title>
    
    <script type="text/javascript">
	function setDefaultValue() {
		var eResults = document.getElementById('results');
		eResults.style.display="none"
		var eAjaxIcon = document.getElementById('ajaxIcon');
		eAjaxIcon.style.display="inline"
	}
    
	function addResults(response) {  
		var eAjaxIcon = document.getElementById('ajaxIcon');
		eAjaxIcon.style.display="none"

		var eContent = document.getElementById('content');
		while(eContent.firstChild) {
			eContent.removeChild(eContent.firstChild);
		}
			
		var eResults = document.getElementById('results');
		if (eResults.style.display=="none") eResults.style.display="block"

		for(var i=0; i< response.users.length; i++) {
			var eTr = document.createElement('tr');
			var eUsername = document.createElement('td');
			var eLink = document.createElement('a');
			eLink.href = "showUser/" + response.users[i].id;
			eLink.innerHTML = response.users[i].username;
			eUsername.appendChild(eLink);
			eTr.appendChild(eUsername);
			var displayName = ""
			if(response.users[i].displayName!=null && response.users[i].displayName.trim().length>0) {
				displayName = " ("+response.users[i].displayName+")";
			}
			var eName = document.createElement('td');
			eName.innerHTML = response.users[i].name + displayName;
			eTr.appendChild(eName);
			var eAdmin = document.createElement('td');
			eAdmin.innerHTML = response.users[i].isAdmin;
			eTr.appendChild(eAdmin);
			var eMgr = document.createElement('td');
			eMgr.innerHTML = response.users[i].isManager;
			eTr.appendChild(eMgr);
			var eUsr = document.createElement('td');
			eUsr.innerHTML = response.users[i].isUser;
			eTr.appendChild(eUsr);
			var eCreation = document.createElement('td');
			eCreation.innerHTML = response.users[i].dateCreated;
			eTr.appendChild(eCreation);
			var eStatus = document.createElement('td');
			eStatus.innerHTML = response.users[i].status;
			eTr.appendChild(eStatus);
			eContent.appendChild(eTr);

			var eLink = document.createElement('a');
			eLink.href =  '${appBaseUrl}/administrator/enrollUserInGroup?user=' +response.users[i].id + '&group=' + '${group.id}';
			eLink.innerHTML = "Enroll"
			var eImg = document.createElement('img');
			//eImg.src = '/DomeoDashboard/static/images/dashboard/add_user.png';
			var eAct = document.createElement('td');
			eAct.appendChild(eImg);
			eAct.appendChild(eLink);
			eTr.appendChild(eAct);
			
			eContent.appendChild(eTr);
		}
	}
	</script>
  </head>

	<body>
		 <div class="title">
			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'search.png')}"/> Add Users to Group: ${group.name}
		</div>
		<g:render template="addUsersToGroup" />
	</body>
</html>