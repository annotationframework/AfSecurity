<!DOCTYPE html>
<%-- by Paolo Ciccarese paolo.ciccarese@gmail.com --%>

<html>
 	<head>
    	<meta name="layout" content="administrator-dashboard" />
		<title>Group: ${item.name} :: ${grailsApplication.config.af.shared.title}</title>
  	</head>
	<body>
	  	<script type="text/javascript">
		  	$(document).ready(function() {
			  	var dataToSend = { id: '${item.id}' };
			  	$.ajax({
			  	  	url: "${appBaseUrl}/ajaxDashboard/groupUsers",
			  	  	context: $("#usersContent"),
			  	  	data: dataToSend,
			  	  	success: function(data){
			  	  		$('#groupsContent').html('');
			  			var label = data.length == 1 ? data.length + ' User' : data.length + ' Users';
			  			$("#usersTitle").html("<b>"+label+"</b>");
			  			$.each(data, function(i,item){
			  				$('#usersTable').append('<tr><td><a href="${request.getContextPath()}/administrator/showUser/' + 
					  				item.user.id + '">' + item.user.displayName + '</a></td><td>' + 
					  				item.user.email + '</td><td>'+ 
					  				getRoles(item.roles) + '</td><td>'+ 
					  				item.dateCreated + '</td></tr>');
			  		    });
			  					  			
				  	}
			  	});
		  	});

		  	function getRoles(roles) {
			  	var res = ""
				for(var i=0; i<roles.length; i++) {
					res += roles[i].label
				}
				return res;
			}		  	
	  	</script>
		
		<div class="title">
			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'groups.png',plugin:'users-module')}"/> 
				Group: ${item?.name}
		</div>
		<table class="simpleTableNoBorder">
			<tr>
				<td valign="top"><g:render template="/administrator/showGroup" /></td>
				<td valign="top">
					<div>Enrolls <span id="usersTitle" style="display: inline;"></span></div>
    				<g:render template="/shared/ajaxShowGroupUsers" />
				</td>
			</tr>
		</table>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.dateFormat-1.0.js',plugin:'users-module')}"></script>
	</body>
</html>