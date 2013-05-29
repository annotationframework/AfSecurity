<div id="request" class="sectioncontainer">
	<g:formRemote name="from_form"
	     url="[controller:'administrator', action:'performSarchUser']"
	     before="setDefaultValue();"
	     onSuccess="addResults(data)">
	     
	    <div class="dialog" >
	   
	    <div style="padding-left: 5px; padding-top: 10px;">
			<table style="width:840px; border: 1px #ddd solid;" class="simpleTable">
				<tbody>     
					<tr class="prop">          
						<td class="name" valign="top">Last Name:</td>             
						<td class="value" valign="top"><input name="lastName" value="${lastName}" type="text"></td>                   
						<td class="name" valign="top">First Name:</td>             
						<td class="value" valign="top"><input name="firstName" value="${firstName}" type="text"></td>            
						<td class="name" valign="top">or by Display Name:</td>             
						<td class="value" valign="top"><input name="displayName" value="${displayName}" type="text"></td>   
						<td style="padding-left: 4px;width: 20px; display: block; padding-top:6px;"><span id="ajaxIcon" class="ajaxIcon" style="display:none;"><img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}"/></span></td>
						<td><input type="submit" value="Search" /></td>
					</tr>
				</tbody>	
			</table>
		</div>
</div>
	
	</g:formRemote>
</div>