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
	<title>:: Add Administrators to System: ${system.name}</title>
	
    <g:javascript library="jquery" plugin="jquery"/>
    

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
			eLink.href = "../showUser/" + response.users[i].id;
			eLink.innerHTML = response.users[i].name;
			eUsername.appendChild(eLink);
			eTr.appendChild(eUsername);

			var eSom = document.createElement('td');
			eSom.innerHTML = response.users[i].email;
			eTr.appendChild(eSom);
			
			var eDat = document.createElement('td');
			eDat.innerHTML = response.users[i].dateCreated;
			eTr.appendChild(eDat);
			
			var eUsr = document.createElement('td');
			eUsr.innerHTML = response.users[i].status;
			eTr.appendChild(eUsr);

			var eLink = document.createElement('a');
			eLink.href =  '${appBaseUrl}/dashboard/addAdministratorToSystem?user=' +response.users[i].id + '&system=' + '${system.id}';
			eLink.innerHTML = "Add to system"
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
			Add Administrators to System: ${system.name}
		</div>
		<g:render template="/shared/searchUserForm" />
		<g:render template="/shared/searchUserResults" />
	</body>
</html>