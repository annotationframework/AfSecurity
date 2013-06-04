<div id="request" class="sectioncontainer">
	<g:formRemote name="from_form"
     	url="[controller:'dashboard', action:'performGroupSearch']"
     	before="setDefaultValue();"
     	onSuccess="addResults(data)">
     	<g:hiddenField name="id" value="${item?.id}" />
		<div class="dialog" >
			<div style="padding-left: 5px; padding-top: 10px;">
				<table style="width: 900px; border: 1px #ddd solid;" class="simpleTable">
					<tbody>
						<tr class="prop">             
							<td class="name" valign="top">Name:</td>             
							<td class="value" valign="top"><input name="name" value="${name}" type="text"></td>                  
							<td class="name" valign="top">Short name:</td>             
							<td class="value" valign="top"><input name="shortName" value="${shortName}" type="text"></td>  
							<td class="name" valign="top"><input name="hideempty" value="${hideempty}" type="checkbox"> Include empty</td> 
							<td class="name" valign="top"><input name="onlyactive" value="${onlyactive}" type="checkbox"> Include inactive</td>   
							<td style="padding-left: 4px;width: 20px; display: block; padding-top:6px;"><span id="ajaxIcon" class="ajaxIcon" style="display:none;"><img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}"/></span></td>
							<td style="padding-left: 4px;"><input type="submit" value="Search groups" style="width:120px" /></td>
						</tr>
					</tbody>	
				</table>
			</div>
		</div>
	</g:formRemote>
</div>