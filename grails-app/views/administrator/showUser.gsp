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
			  			$("#groupsSpinner").css("display","none");
			  			var label = data.length == 1 ? data.length + ' Group' : data.length + ' Groups';
			  			$("#groupsTitle").html("<b>"+label+"</b>");
			  			if(data.length> 0) {
			  				$('#groupsContent').html('');
				  			$.each(data, function(i,item){
					  			var roles ="";
								for(var i=0; i<item.roles.length; i++) {
									roles+=item.roles[i].label
								}
				  				$('#groupsTable').append('<tr><td><a href="${request.getContextPath()}/administrator/showGroup/' + 
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
		  	});  			  	
	  	</script>
	  	    	
	  	<div class="title">
	  		<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'user.png',plugin:'users-module')}"/>
	  			User: ${user?.displayName} 
	  	</div>
		<table class="simpleTableNoBorder" style="margin-top: 10px;"> 
			<tr>
				<td valign="top" width="500px"><g:render template="/administrator/showUser" /></td>
				<td valign="top">
					<div>Belongs to <span id="groupsTitle" style="display: inline;"></span></div>
    				<g:render template="/shared/ajaxShowUserGroups" />
				</td>
			</tr>
		</table>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.dateFormat-1.0.js',plugin:'users-module')}"></script>
	</body>
</html>