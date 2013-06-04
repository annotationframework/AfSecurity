<%-- by Paolo Ciccarese --%>
<%-- 
Parameters list
 1) item | instance of GroupCreateCommand
Stylesheet
 1) fieldError | background and font color in erroneous text fields
--%>
<div class="sectioncontainer">
	<div class="dialog" style="width: 560px">
		<fieldset>
			<div class="list tablescroll">
				<table id="usersTable" style="border: 1px solid #ddd;" class="tablelist">
					<thead>
						<tr>
							<g:sortableColumn property="username" title="${message(code: 'agentPerson.id.label', default: 'Name')}" />
							<g:sortableColumn property="name" title="${message(code: 'agentPerson.id.label', default: 'Email')}" />
							<g:sortableColumn property="role" title="${message(code: 'agentPerson.id.label', default: 'Role')}" />
							<th>${message(code: 'agentPerson.id.label', default: 'Mamber Since')}</th>
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
					<g:link class="edit" controller="dashboard" action="manageUsersInGroup" id="${item.id}" style="text-decoration: none;">
						<img src="${resource(dir: 'images/dashboard', file: 'edit_group.png')}" alt="Manage Groups" style="display: inline" />Manage Group Users
					</g:link>
				</span>
				&nbsp;
				<span class="button">
					<g:link class="edit" controller="dashboard" action="addUsersToGroup" id="${item.id}" style="text-decoration: none;">
						<img src="${resource(dir: 'images/dashboard', file: 'add_group.png')}" alt="Add Users" style="display: inline" />Enroll Users to Group</g:link>
				</span>
			</div>
		</fieldset> 
	</div>
</div>
