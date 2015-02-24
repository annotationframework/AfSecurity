<%@ page import="org.mindinformatics.ann.framework.module.security.utils.GroupUtils" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultGroupStatus" %>
<div id="request" class="sectioncontainer">
<div class="dialog">
	
<div class="list">
	<g:set var="g" value="${group}"/>
	<table class="tablelist">
		<thead>
			<tr>
				<g:sortableColumn property="name" title="${message(code: 'agentPerson.id.label', default: 'Name')}" />
				<g:sortableColumn property="shortName" title="${message(code: 'agentPerson.id.label', default: 'Short')}" />
				<g:sortableColumn property="description" title="${message(code: 'agentPerson.id.label', default: 'Description')}" />
				<g:sortableColumn property="dateCreated" title="${message(code: 'agentPerson.id.label', default: 'Created on')}" />
				<g:sortableColumn property="lastUpdated" title="${message(code: 'agentPerson.id.label', default: 'Last updated')}" />
				<g:sortableColumn property="status" title="${message(code: 'agentPerson.id.label', default: 'Status')}" />
				<g:sortableColumn property="groupsCount" title="${message(code: 'agentPerson.id.label', default: '#Admins')}" />
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<g:if test="${systems.size()==0}">
				<tr>
					<td colspan="8">No Systems have been defined</td>
				</tr>
			</g:if>
			<g:each in="${systems}" status="i" var="group">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		     		<td>
						<g:link action="showSystem" id="${group.id}">
		     				${group.name}
						</g:link>
		     		</td>
		     		<td>
						${group.shortName}
		     		</td>
		     		<td>
						${group.description}
		     		</td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${group.dateCreated}"/></td>
		     		<td><g:formatDate format="MM/dd/yyyy hh:mm" date="${group.lastUpdated}"/></td>
		     		<td>	
		     			<g:if test="${group.enabled==true}">Enabled</g:if>
			     		<g:else>Disabled</g:else>
		     		</td>
		     		<td>
		     			<g:each in="${systemsCount}" var="groupCount">
		     				<g:if test="${groupCount.key == group.id}">
		     						${groupCount.value}
		     				</g:if>
		     			</g:each>
		     		</td>
		     		
		     		<td>
			     		<div class="buttons">
			     		
							<g:form>
								<g:hiddenField name="id" value="${group?.id}" /> 
								<g:hiddenField name="redirect" value="listSystems" />
								<span class="button">
									<g:link class="edit" action="editSystem">${message(code: 'default.button.edit.account.label', default: 'Edit')}</g:link>
								</span>
								<g:if test="${group.enabled!=true}">
									<span class="button">
										<g:actionSubmit class="enable" action="enableSystem" value="${message(code: 'default.button.enable.account.label', default: 'Enable')}" />
									</span>
								</g:if>
								<g:elseif test="${group.enabled==true}">
									<span class="button">
										<g:actionSubmit class="disable" action="disableSystem" value="${message(code: 'default.button.disable.account.label', default: 'Disable')}" 
											onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to disable the group: '+group.shortName+' ?')}');" />
									</span>
								</g:elseif>
								<g:if test="${systemsCount[group.id] == 0}">
									<span class="button">
										<g:link class="delete" action="deleteSystem" id="${group?.id}"
											onclick="return confirm('${message(code: 'default.button.delete.account.confirm.message', default: 'Are you sure you want to delete the group: '+group.shortName+' ?')}');">
											${message(code: 'default.button.delete.account.label', default: 'Delete')}</g:link>
									</span>
								</g:if>
								<%-- 
								<g:if test="${GroupUtils.getStatusValue(group) == DefaultGroupStatus.LOCKED.value()}">
									<span class="button">
										<g:actionSubmit class="unlock" action="unlockGroup" value="${message(code: 'default.button.unlock.account.label', default: 'Unlock')}" />
									</span>
								</g:if>
								<g:elseif test="${GroupUtils.getStatusValue(group) != DefaultGroupStatus.LOCKED.value()}">
									<span class="button">
										<g:actionSubmit class="lock" action="lockGroup" value="${message(code: 'default.button.lock.account.label', default: 'Lock')}"
										onclick="return confirm('${message(code: 'default.button.lock.account.confirm.message', default: 'Are you sure you want to lock the group: '+group.shortName+' ?')}');" />
									</span>
								</g:elseif>
								

								--%>
							</g:form>
						
						</div>	     		
		     		</td>
		     	</tr>
			</g:each>
		</tbody>
	</table>
	<div class="paginateButtons">
   		<g:paginate total="${systemsTotal}" />
	</div>
</div>
</fieldset>
</div>
</div>