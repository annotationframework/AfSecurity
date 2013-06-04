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
				<g:sortableColumn property="isAdmin" title="${message(code: 'agentPerson.id.label', default: 'Adm')}" />
				<g:sortableColumn property="isManager" title="${message(code: 'agentPerson.id.label', default: 'Mgr')}" />
				<g:sortableColumn property="isUser" title="${message(code: 'agentPerson.id.label', default: 'Usr')}" />
				<g:sortableColumn property="dateCreated" title="${message(code: 'agentPerson.id.label', default: 'Member Since')}" />
				<g:sortableColumn property="lastUpdated" title="${message(code: 'agentPerson.id.label', default: 'Last updated')}" />
				<g:sortableColumn property="status" title="${message(code: 'agentPerson.id.label', default: 'Status')}" />
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<g:each in="${users}" status="i" var="user">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		     		<td><g:link action="showUser" id="${user.id}">${user.username}</g:link></td>
		     		<td>${user.lastName} ${user.firstName} <g:if test="${user?.displayName?.length()>0}">(${user.displayName})</g:if></td>

					<g:set var="userObject" value="${User.findByUsername(user.username)}"/>
					<g:set var="userRole" value="${UserRole.findAllByUser(userObject)}"/>
						
		     		<td>
		     			<g:if test="${userRole.role.authority.contains(DefaultUsersRoles.ADMIN.value())}">Y</g:if>
				    </td>
				    <td>
				    	<g:if test="${userRole.role.authority.contains(DefaultUsersRoles.MANAGER.value())}">Y</g:if>
				    </td>
				     <td>
				     	<g:if test="${userRole.role.authority.contains(DefaultUsersRoles.USER.value())}">Y</g:if>
				    </td>

		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${user.dateCreated}"/></td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${user.lastUpdated}"/></td>
		     		<td>
		     			${UserUtils.getStatusLabel(userObject)}
		     		<%--
						${user.status}
					--%>
					</td>
		     		<td>
		     			<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${system?.id}" /> 
								<g:hiddenField name="user" value="${user.id}" /> 
								<g:hiddenField name="redirect" value="manageUsersOfSystem" />
								<g:hiddenField name="redirectId" value="${system?.id}" />
									<span class="button">
										<g:actionSubmit class="deleteUser" action="removeUserFromSystem" value="${message(code: 'default.button.edit.account.label', default: 'Remove')}" 
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
   		<g:paginate total="${usersTotal}" params="[groupId: groupId]"/>
	</div>
</div>
</div>
</div>