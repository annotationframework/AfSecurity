<%-- by Paolo Ciccarese --%>
<%-- 
Parameters list
 1) item | instance of GroupCreateCommand
Stylesheet
 1) fieldError | background and font color in erroneous text fields
--%>
<div class="sectioncontainer">
	<div class="dialog" style="width: 465px" >
		<fieldset>
			<div class="list tablescroll">
				<table id="openIdsTable" style="border: 1px solid #ddd;" class="tablelist">
					<thead>
						<tr>
							<th>${message(code: 'agentPerson.id.label', default: 'OpenID')}</th>
						</tr>
					</thead>
					<tbody id="openIdsContent">
						<tr>
							<td>
								<img style="display: inline;" id="openIdsSpinner" src="${resource(dir:'images/shared',file:'spinner.gif',plugin:'af-shared')}" /> Loading Administered Systems
							</td>
						</tr>
					</tbody>
				</table>
				<div class="paginateButtons">
			   		<g:paginate total="1" />
				</div>
			</div>
			<%-- 
				<div>
				<span class="button">
					<g:link class="edit" controller="dashboard" action="manageGroupsOfUser"  id="${user.id}" style="text-decoration: none;"><img src="${resource(dir: 'images/dashboard', file: 'edit_group.png')}" alt="Manage Groups" style="display: inline" />Manage User's Groups</g:link>
				</span>
				&nbsp;
				<span class="button">
					<g:link controller="dashboard" action="enrollUserInGroups" id="${user.id}" style="text-decoration: none;"><img src="${resource(dir: 'images/dashboard', file: 'add_group.png')}" alt="Add Groups" style="display: inline" />Enroll User in Groups</g:link>
				</span>
			</div>
			--%>
		</fieldset> 
	</div>
</div>
