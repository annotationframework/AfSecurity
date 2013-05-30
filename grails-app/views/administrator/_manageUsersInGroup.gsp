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
			<g:each in="${groupusers}" status="i" var="groupuser">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		     		<td><g:link action="showUser" id="${groupuser.user.id}">${groupuser.user.username}</g:link></td>
		     		<td>${groupuser.user.lastName} ${groupuser.user.firstName} <g:if test="${groupuser.user?.displayName?.length()>0}">(${groupuser.user.displayName})</g:if></td>

					<g:set var="userObject" value="${User.findByUsername(groupuser.user.username)}"/>
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

		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${groupuser.dateCreated}"/></td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${groupuser.lastUpdated}"/></td>
		     		<td>
		     			${UserUtils.getStatusLabel(userObject)}
		     		<%--
						${user.status}
					--%>
					</td>
		     		<td>
		     			<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${group?.id}" /> 
								<g:hiddenField name="user" value="${groupuser.user.id}" /> 
								<g:hiddenField name="redirect" value="manageUsersInGroup" />
								<g:hiddenField name="redirectId" value="${group?.id}" />
									<span class="button">
										<g:actionSubmit class="edit" action="editUserRoleInGroup" value="${message(code: 'default.button.edit.account.label', default: 'Edit Role')}" />
									</span>
									<g:if test="${groupuser.status.value == 'IG_LOCKED'}">
										<span class="button">
											<g:actionSubmit class="unlock" action="unlockUserinGroup" value="${message(code: 'default.button.unlock.account.label', default: 'Unlock')}" />
										</span>
									</g:if>
									<g:elseif test="${groupuser.status.value == 'IG_ACTIVE' || groupuser.status.value == 'IG_SUSPENDED' || usergroup.status.value == 'IG_DELETED'}">
										<span class="button">
											<g:actionSubmit class="lock" action="lockUserInGroup" value="${message(code: 'default.button.lock.account.label', default: 'Lock')}"
											onclick="return confirm('${message(code: 'default.button.lock.account.confirm.message', default: 'Are you sure you want to lock the user membership in this group?')}');" />
										</span>
									</g:elseif>
									<g:if test="${groupuser.status.value == 'IG_SUSPENDED' || groupuser.status.value == 'IG_DELETED'}">
										<span class="button">
											<g:actionSubmit class="enable" action="enableUserInGroup" value="${message(code: 'default.button.enable.account.label', default: 'Activate')}" />
										</span>
									</g:if>
									<g:elseif test="${groupuser.status.value == 'IG_ACTIVE' || groupuser.status.value == 'IG_LOCKED'}">
										<span class="button">
											<g:actionSubmit class="disable" action="disableUserInGroup" value="${message(code: 'default.button.disable.account.label', default: 'Suspend')}" 
											onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to disable the user membership in this group?')}');"/>
										</span>
									</g:elseif>
									<span class="button">
										<g:actionSubmit class="deleteUser" action="removeUserFromGroup" value="${message(code: 'default.button.edit.account.label', default: 'Remove')}" 
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