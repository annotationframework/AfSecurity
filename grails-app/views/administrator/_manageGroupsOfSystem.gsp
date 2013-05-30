<div id="request" class="sectioncontainer">
<div class="dialog">
	<div class="title">Groups List for ${system.name} - total# ${systemgroups.size()}</div>

<div class="list">
	<g:set var="g" value="${system}"/>
	<table class="tablelist">
		<thead>
			<tr>
				<g:sortableColumn property="name" title="${message(code: 'agentPerson.id.label', default: 'Name')}" />
				<g:sortableColumn property="nickname" title="${message(code: 'agentPerson.id.label', default: 'Short')}" />
				<g:sortableColumn property="description" title="${message(code: 'agentPerson.id.label', default: 'Description')}" />
				<g:sortableColumn property="role" title="${message(code: 'agentPerson.id.label', default: 'Privacy')}" />
				<g:sortableColumn property="role" title="${message(code: 'agentPerson.id.label', default: '#Members')}" />
				<th>Actions</th>
		</thead>
		<tbody>
			<g:each in="${systemgroups}" status="i" var="systemgroup">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		     		<td>
						<g:link action="showGroup" id="${systemgroup.id}">
		     				${systemgroup.name}
						</g:link>
		     		</td>
		     		<td>
						${systemgroup.shortName}
		     		</td>
		     		<td>
						${systemgroup.description}
		     		</td>
		     		<td>
		     			${systemgroup?.privacy?.label}
		     		</td>
		     		<td>
		     			<g:each in="${systemsCount}" var="systemCount">
		     				<g:if test="${systemCount.key == systemgroup.id}">		     					
		     					<g:if test="${systemCount.value>0}">
			     					<g:link controller="dashboard" action="listGroupUsers" id="${system.id}">
			     						${systemCount.value}
			     					</g:link>
		     					</g:if>
		     					<g:else>
		     						${systemCount.value}
		     					</g:else>
		     				</g:if>
		     			</g:each>
		     		</td>
		     		<td>
			     		<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${systemgroup.id}" /> 
								<g:hiddenField name="system" value="${system.id}" /> 
								<g:hiddenField name="redirect" value="manageGroupsOfSystem" />
									<span class="button">
										<g:actionSubmit class="deleteGroup" action="removeGroupFromSystem" value="${message(code: 'default.button.edit.account.label', default: 'Remove')}" 
										onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to remove the user from the group?')}');"/>
									</span>
							</g:form>
						</div>	     		
		     		</td>
		     		
		     		<%-- 
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${usergroup.dateCreated}"/></td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${usergroup.lastUpdated}"/></td>
		     		<td>
			
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		     		<td>
						<g:link action="showGroup" id="${usergroup.group.id}">
		     				${usergroup.group.name}
						</g:link>
		     		</td>
		     		<td>
						${usergroup.group.shortName}
		     		</td>
		     		<td>
						${usergroup.group.description}
		     		</td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${usergroup.dateCreated}"/></td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${usergroup.lastUpdated}"/></td>
		     		<td>
		     			<g:each in="${usergroup.roles}">
			     			${it.label}
			     		</g:each>
		     		</td>
		     		<td>
			     		${usergroup.status.label}
		     		</td>
		     		<td>
			     		<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${usergroup.group?.id}" /> 
								<g:hiddenField name="user" value="${user.id}" /> 
								<g:hiddenField name="redirect" value="manageUserGroups" />
									<span class="button">
										<g:actionSubmit class="edit" action="editUserRoleInGroup" value="${message(code: 'default.button.edit.account.label', default: 'Edit Role')}" />
									</span>
									<g:if test="${usergroup.status.value == 'IG_LOCKED'}">
										<span class="button">
											<g:actionSubmit class="unlock" action="unlockUserinGroup" value="${message(code: 'default.button.unlock.account.label', default: 'Unlock')}" />
										</span>
									</g:if>
									<g:elseif test="${usergroup.status.value == 'IG_ACTIVE' || usergroup.status.value == 'IG_SUSPENDED' || usergroup.status.value == 'IG_DELETED'}">
										<span class="button">
											<g:actionSubmit class="lock" action="lockUserInGroup" value="${message(code: 'default.button.lock.account.label', default: 'Lock')}"
											onclick="return confirm('${message(code: 'default.button.lock.account.confirm.message', default: 'Are you sure you want to lock the user membership in this group?')}');" />
										</span>
									</g:elseif>
									<g:if test="${usergroup.status.value == 'IG_SUSPENDED' || usergroup.status.value == 'IG_DELETED'}">
										<span class="button">
											<g:actionSubmit class="enable" action="enableUserInGroup" value="${message(code: 'default.button.enable.account.label', default: 'Activate')}" />
										</span>
									</g:if>
									<g:elseif test="${usergroup.status.value == 'IG_ACTIVE' || usergroup.status.value == 'IG_LOCKED'}">
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
		     	--%>
			</g:each>
		</tbody>
	</table>
	<div class="paginateButtons">
   		<g:paginate total="${numbergroups}" />
	</div>
</div>
</fieldset>
</div>
</div>