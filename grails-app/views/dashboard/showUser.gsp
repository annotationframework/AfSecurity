<!DOCTYPE html>
<%-- by Paolo Ciccarese paolo.ciccarese@gmail.com --%>

<html>
  	<head>
	    <meta name="layout" content="administrator-dashboard" />
	    <title>User: ${user?.firstName} ${user?.lastName} 
	    	<g:if test="${user?.displayName?.length()>0}">(${user.displayName})</g:if>
	    	:: ${grailsApplication.config.af.shared.title}
	    </title>	    	
  	</head>

	<body>	  	
	  	<script type="text/javascript">
		  	$(document).ready(function() {			  	
			  	var dataToSend = { id: '${user.id}' };
			  	$.ajax({
			  	  	url: "${appBaseUrl}/ajaxDashboard/userGroups",
			  	  	context: $("#groupsContent"),
			  	  	data: dataToSend,
			  	  	success: function(data){
			  			var label = data.length == 1 ? data.length + ' Group' : data.length + ' Groups';
			  			$("#groupsTitle").html("<b>"+label+"</b>");
			  			if(data.length> 0) {
			  				$('#groupsContent').html('');
				  			$.each(data, function(i,item){
					  			var roles ="";
								for(var i=0; i<item.roles.length; i++) {
									roles+=item.roles[i].label
								}
				  				$('#groupsTable').append('<tr><td><a href="${request.getContextPath()}/dashboard/showGroup/' + 
						  				item.group.id + '">' + item.group.name + '</a></td><td>' + 
						  				item.dateCreated + '</td><td>'+ roles +
						  				'</td><td> '+ item.status.label + '</td></tr>');
				  		    });
			  			} else {
			  				$('#groupsContent').html('');
			  				$('#groupsTable').append('<tr><td>No groups defined</td><td></td><td></td></tr>');
				  		}		  			
				  	}
			  	});
			  	$.ajax({
			  	  	url: "${appBaseUrl}/ajaxDashboard/userAdministeredSystems",
			  	  	context: $("#systemsContent"),
			  	  	data: dataToSend,
			  	  	success: function(data){
			  			var label = data.length == 1 ? data.length + ' System' : data.length + ' Systems';
			  			$("#systemsTitle").html("<b>"+label+"</b>");
			  			if(data.length> 0) {
			  				$('#systemsContent').html('');
				  			$.each(data, function(i,item){
					  			/*
								for(var i=0; i<item.systems.length; i++) {
									roles+=item.roles[i].label
								}
								*/
				  				$('#systemsTable').append('<tr><td><a href="${request.getContextPath()}/dashboard/showSystem/' + 
						  				item.system.id + '">' + item.system.name + '</a></td><td>' + 
						  				item.system.createdBy.displayName +
						  				'</td><td> '+  (item.system.enabled==true?'Enabled':"Disabled") + '</td></tr>');
				  		    });
			  			} else {
			  				$('#systemsContent').html('');
			  				$('#systemsTable').append('<tr><td>No Systems</td><td></td><td></td></tr>');
				  		}		  			
				  	}
			  	});
				$.ajax({
			  	  	url: "${appBaseUrl}/ajaxDashboard/userOpenIds",
			  	  	context: $("#openIdsContent"),
			  	  	data: dataToSend,
			  	  	success: function(data){
			  			var label = data.length == 1 ? data.length + ' OpenID' : data.length + ' OpenIDs';
			  			$("#openIdsTitle").html("<b>"+label+"</b>");
			  			if(data.length> 0) {
			  				$('#openIdsContent').html('');
				  			$.each(data, function(i,item){
				  				$('#openIdsTable').append('<tr><td>' + item.url + '</td></tr>');
				  		    });
			  			} else {
			  				$('#openIdsContent').html('');
			  				$('#openIdsTable').append('<tr><td>No OpenIDs</td></tr>');
				  		}		  			
				  	}
			  	});
		  	});  			  	
	  	</script>
	  	    	
	  	<div class="title">
	  		<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'user.png',plugin:'users-module')}"/>
	  			User: ${user?.displayName} 
	  	</div>
		<g:render template="message" />
		<table class="simpleTableNoBorder" style="margin-top: 10px;"> 
			<tr>
				<td valign="top" width="500px">
					<g:render template="showUser" />
					<br/>
					<div><span id="openIdsTitle" style="display: inline;"></span></div>
					<g:render template="/shared/ajaxShowUserOpenIds" />
				</td>
				<td valign="top">
					<div>Belongs to <span id="groupsTitle" style="display: inline;"></span></div>
    				<g:render template="/shared/ajaxShowUserGroups" />
    				<br/>
    				<div>Administers <span id="systemsTitle" style="display: inline;"></span></div>
    				<g:render template="/shared/ajaxShowUserAdministeredSystems" />
    				<%-- <g:render template="/shared/ajaxShowUserGroups" /> --%>
				</td>
			</tr>
		</table>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.dateFormat-1.0.js',plugin:'users-module')}"></script>
	</body>
</html>