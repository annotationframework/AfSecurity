<!DOCTYPE html>
<%-- by Paolo Ciccarese paolo.ciccarese@gmail.com --%>

<html>
	<head>
    	<meta name="layout" content="administrator-dashboard" />
    	<title>System: ${item.name} :: ${grailsApplication.config.af.shared.title}</title>
  	</head>

	<body>
	  	<script type="text/javascript">
		  	$(document).ready(function() {
			  	var dataToSend = { id: '${item.id}' };
			  	$.ajax({
			  		type: "GET",
			  		url: "${appBaseUrl}/ajaxDashboard/systemGroups",
			  	  	context: $("#groupsContent"),
			  	  	data: dataToSend,
			  	    dataType:'json',
			  	    contentType: 'application/json; charset=utf-8'
			  	}).done(function( data ) {
		  			if(data.length>0) {
		  				var label = data.length == 1 ? data.length + ' Group' : data.length + ' Groups';
		  				$("#groupsTitle").html("<b>"+label+"</b>");
		  				$('#groupsContent').html('');
			  			$.each(data, function(i,item){
			  				$('#groupsContent').append('<tr><td><a href="${request.getContextPath()}/dashboard/showUser/' + 
					  				item.id + '">' + item.name + '</a></td><td>' + 
					  				(item.enabled?"enabled":"disabled") + '</td><td>-</td></tr>');
			  		    });
		  			} else {
		  				$("#groupsTitle").html("(<b>0 Groups</b>)");
		  				$('#groupsContent').html('<tr><td colspan="3">No groups</td></tr>');
			  		}	  			
			  	});

				$.ajax({
			  		type: "GET",
			  		url: "${appBaseUrl}/ajaxDashboard/systemAdministrators",
			  	  	context: $("#administratorsContent"),
			  	  	data: dataToSend,
			  	    dataType:'json',
			  	    contentType: 'application/json; charset=utf-8'
			  	}).done(function( data ) {
		  			if(data.length>0) {
		  				var label = data.length == 1 ? data.length + ' Administrator' : data.length + ' Administrators';
		  				$("#administratorsTitle").html("<b>"+label+"</b>");
		  				$('#administratorsContent').html('');
			  			$.each(data, function(i,item){
			  				$('#administratorsContent').append('<tr><td><a href="${request.getContextPath()}/dashboard/showUser/' + 
					  				item.user.id + '">' + item.user.displayName + '</a></td><td>' + item.user.email +
					  				'</td></tr>');

					  				//<td>' + 
					  				//(item.enabled?"enabled":"disabled") + '</td><td>-</td></tr>');
			  		    });
		  			} else {
		  				$("#administratorsTitle").html("<b>0 Users</b>");
		  				$('#administratorsContent').html('<tr><td colspan="3">No administrators</td></tr>');
			  		}	  			
			  	});

				$.ajax({
			  		type: "GET",
			  		url: "${appBaseUrl}/ajaxDashboard/systemUsers",
			  	  	context: $("#usersContent"),
			  	  	data: dataToSend,
			  	    dataType:'json',
			  	    contentType: 'application/json; charset=utf-8'
			  	}).done(function( data ) {
		  			if(data.length>0) {
		  				var label = data.length == 1 ? data.length + ' User' : data.length + ' Users';
		  				$("#usersTitle").html("<b>"+label+"</b>");
		  				$('#usersContent').html('');
			  			$.each(data, function(i,item){
			  				$('#usersContent').append('<tr><td><a href="${request.getContextPath()}/dashboard/showUser/' + 
					  				item.id + '">' + item.displayName + '</a></td><td>' + item.username +
					  				'</td><td>' + item.email +
					  				'</td></tr>');

					  				//<td>' + 
					  				//(item.enabled?"enabled":"disabled") + '</td><td>-</td></tr>');
			  		    });
		  			} else {
		  				$("#usersTitle").html("<b>0 Users</b>");
		  				$('#usersContent').html('<tr><td colspan="3">No users</td></tr>');
			  		}	  			
			  	});
		  	});  			  	
	  	</script>
		
		<div class="title">
			<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'computer.png',plugin:'users-module')}"/> 
				System: ${item?.name}
		</div>
		<table class="simpleTableNoBorder" style="margin-top: 10px;">
			<tr>
				<td valign="top">
					<g:render template="showSystem" /><br/>
					<div>Managed by <span id="administratorsTitle" style="display: inline;"></span></div>
					<g:render template="/shared/ajaxShowSystemAdministrators" /><br/>

				</td>
				<td valign="top">
					<div>Has access to <span id="groupsTitle" style="display: inline;"></span></div>
    				<g:render template="/shared/ajaxShowSystemGroups" /><br/>
    				<div>Has access to <span id="usersTitle" style="display: inline;"></span></div>
    				<g:render template="/shared/ajaxShowSystemUsers" /><br/>
				</td>
			</tr>
		</table>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.dateFormat-1.0.js',plugin:'users-module')}"></script>
	</body>
</html>