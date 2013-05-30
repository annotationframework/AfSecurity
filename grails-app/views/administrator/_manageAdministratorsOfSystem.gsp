<%@ page import="org.mindinformatics.ann.framework.module.security.users.User" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.users.UserRole" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.UserUtils" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultUsersRoles" %>

<div id="request" class="sectioncontainer">
<div class="dialog">
	
<div class="list">
<table class="tablelist">
		<thead>
			<tr>
				<g:sortableColumn property="username" title="${message(code: 'agentPerson.id.label', default: 'Username')}" />
				<g:sortableColumn property="name" title="${message(code: 'agentPerson.id.label', default: 'Name')}" />
				<g:sortableColumn property="dateCreated" title="${message(code: 'agentPerson.id.label', default: 'Administrator Since')}" />
				<g:sortableColumn property="status" title="${message(code: 'agentPerson.id.label', default: 'User Status')}" />
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<g:each in="${systemAdministrators}" status="i" var="systemAdministrator">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		     		<td><g:link action="showUser" id="${systemAdministrator.user.id}">${systemAdministrator.user.username}</g:link></td>
		     		<td>${systemAdministrator.user.lastName} ${systemAdministrator.user.firstName} <g:if test="${systemAdministrator.user?.displayName?.length()>0}">(${systemAdministrator.user.displayName})</g:if></td>

					<g:set var="userObject" value="${User.findByUsername(systemAdministrator.user.username)}"/>
					<g:set var="userRole" value="${UserRole.findAllByUser(userObject)}"/>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${systemAdministrator.dateCreated}"/></td>
		     		<td>
		     			${UserUtils.getStatusLabel(userObject)}
					</td>
		     		<td>
		     			<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${system?.id}" /> 
								<g:hiddenField name="user" value="${systemAdministrator.user.id}" /> 
								<g:hiddenField name="redirect" value="manageAdministratorsOfSystem" />
								<g:hiddenField name="redirectId" value="${system?.id}" />
									<span class="button">
										<g:actionSubmit class="deleteUser" action="removeAdministratorFromSystem" value="${message(code: 'default.button.edit.account.label', default: 'Remove')}" 
										onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to remove the user from the group?')}');"/>
									</span>
							</g:form>
						</div>	     	
		     		</td>
		     	</tr>
			</g:each>
		</tbody>
	</table>
	<div class="paginateButtons">
   		<g:paginate total="${administratorsCount}" params="[systemId: systemId]"/>
	</div>
</div>
</div>
</div>