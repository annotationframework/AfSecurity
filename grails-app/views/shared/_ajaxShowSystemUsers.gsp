<%-- by Paolo Ciccarese --%>
<%-- 
Parameters list
 1) item | instance of GroupCreateCommand
Stylesheet
 1) fieldError | background and font color in erroneous text fields
--%>
<div class="sectioncontainer">
	<div class="dialog" style="width: 660px">
		<fieldset>
			<legend><span id="usersTitle">Loading Users</span> <img id="usersSpinner" src="${resource(dir:'images',file:'spinner.gif',plugin:'domeo-dashboard')}" /></legend>
			<div class="list tablescroll">
				<table id="usersTable" style="border: 1px solid #ddd;" class="tablelist">
					<thead>
						<tr>
							<g:sortableColumn property="name" title="${message(code: 'agentPerson.id.label', default: 'Name')}" style="width: 200px" />
							<g:sortableColumn property="username" title="${message(code: 'agentPerson.id.label', default: 'Username')}" style="width: 200px" />
							<th>${message(code: 'agentPerson.id.label', default: 'Mamber Since')}</th>
						</tr>
					</thead>
					<tbody id="usersContent">
					</tbody>
				</table>
				<div class="paginateButtons">
			   		<g:paginate total="1" />
				</div>
			</div>
			<div>
				<span class="button">
					<g:link class="edit" action="manageUsersOfGroup" id="${item.id}">
						<img src="${resource(dir: 'images/dashboard', file: 'edit_group.png')}" alt="Manage Groups" style="display: inline" />Manage Users
					</g:link>
				</span>
			</div>
		</fieldset> 
	</div>
</div>
