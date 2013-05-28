<%-- by Paolo Ciccarese --%>
<%-- 
Parameters list
 1) item | instance of GroupCreateCommand
Stylesheet
 1) fieldError | background and font color in erroneous text fields
--%>
<div class="sectioncontainer">
	<div class="dialog" style="width: 660px" >
		<fieldset>
			<div class="list tablescroll">
				<table id="groupsTable" style="border: 1px solid #ddd;" class="tablelist">
					<thead>
						<tr>
							<th style="width: 200px">${message(code: 'agentPerson.id.label', default: 'Group Name')}</th>
							<th style="width: 200px">${message(code: 'agentPerson.id.label', default: 'Status')}</th>
							<th>${message(code: 'agentPerson.id.label', default: '#Members')}</th>
						</tr>
					</thead>
					<tbody id="groupsContent">
						<tr>
							<td>
								<img style="display: inline;" id="groupsSpinner" src="${resource(dir:'images/shared',file:'spinner.gif',plugin:'af-shared')}" /> Loading System Groups
							</td>
						</tr>
					</tbody>
				</table>
				<div class="paginateButtons">
			   		<g:paginate total="1" />
				</div>
			</div>
			<div>
				<span class="button">
					<g:link class="edit" controller="administrator" action="manageSystemGroups"  id="${item.id}" style="text-decoration: none;">
						<img src="${resource(dir: 'images/dashboard', file: 'edit_group.png')}" alt="Manage Groups" style="display: inline" />Manage System Groups
					</g:link>
					&nbsp;
					<span class="button">
						<g:link controller="administrator" action="addGroupsToSystem" id="${item.id}" style="text-decoration: none;">
						<img src="${resource(dir: 'images/dashboard', file: 'add_group.png')}" alt="Add Groups" style="display: inline" />Add System Groups</g:link>
					</span>
				</span>
			</div>
		</fieldset> 
	</div>
</div>
