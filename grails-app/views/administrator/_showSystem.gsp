<%-- by Paolo Ciccarese --%>
<%-- 
Parameters list
 1) item | instance of GroupCreateCommand
Stylesheet
 1) fieldError | background and font color in erroneous text fields
--%>
<%@ page import="org.mindinformatics.ann.framework.module.security.groups.GroupStatus" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.GroupUtils" %>
<div class="sectioncontainer">
<div class="dialog" >
	<fieldset>
    	<legend>Group Profile </legend>
		<table class="simpleTable" style="width: 460px; border: 5px solid #fff;">
			<tbody>
				<tr>
					<td valign="top" width="80px"  align="left">
						<label for="name">Name</label>
					</td>
					<td valign="top" width="265px" align="left">
						${item?.name}
					</td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="nickname">Short Name</label>
					</td>
					<td valign="top" align="left">
						${item?.shortName}
					</td>
				</tr> 
				<tr>
					<td valign="top"  align="left">
						<label for="description">Description</label>
					</td>
					<td valign="top" align="left">
						${item?.description}
					</td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="description">Created by</label>
					</td>
					<td valign="top" align="left">
						<g:link action="showUser" id="${item?.createdBy.id}">${item?.createdBy.displayName}</g:link>
					</td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="status">Status</label>
					</td>
					<td valign="top" align="left">
						<g:if test="${item?.enabled==true}">Enabled</g:if>
						<g:else>Disabled</g:else>
					</td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="description">API key</label>
					</td>
					<td valign="top" align="left">
						${item?.apikey}
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${item?.id}" /> 
								<g:hiddenField name="redirect" value="listGroups" />
								<span class="button">
									<g:actionSubmit class="edit" action="editSystem" value="${message(code: 'default.button.edit.account.label', default: 'Edit system')}" />
								</span>
								<span class="button">
									<g:actionSubmit class="reload" action="regenerateSystemApiKey" value="${message(code: 'default.button.edit.account.label', default: 'Regenerate key')}"
										onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to regenerate the API key? All clients will have to update the API access key.')}');" />
								</span>
							</g:form>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		</fieldset>
</div>
</div>
