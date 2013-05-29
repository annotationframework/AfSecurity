<div id="results" style="display:none;" class="sectioncontainer">
				<div class="list" >
			<table class="tablelist">
				<thead>
					<tr>
						<g:sortableColumn property="username" title="${message(code: 'agentPerson.id.label', default: 'Username')}" />
						<g:sortableColumn property="name" title="${message(code: 'agentPerson.id.label', default: 'Email')}" />
						<g:sortableColumn property="dateCreated" title="${message(code: 'agentPerson.id.label', default: 'Member Since')}" />
						<g:sortableColumn property="status" title="${message(code: 'agentPerson.id.label', default: 'Status')}" />
						<th>Actions</th>
					</tr>
				</thead>
				<tbody id="content">
				</tbody>
			</table>
			<div class="paginateButtons">
		   		<g:paginate total="1" />
			</div>
		</div>
</div>
