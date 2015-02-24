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
<div class="dialog" style="border: 2px solid #ddd; width: 461px; border-radius: 15px; background: #efefef;">
		<table class="simpleTable" style="width: 460px; border: 5px solid #efefef;margin-top:10px;">
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
						<label for="apikey">API key</label>
					</td>
					<td valign="top" align="left">
						${item?.apikey}
					</td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="secretKey">Secret key</label>
					</td>
					<td valign="top" align="left">
						${item?.secretKey}
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
									<g:actionSubmit class="reload" action="regenerateSystemApiKey" value="${message(code: 'default.button.edit.account.label', default: 'Regenerate API key')}"
										onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to regenerate the API key? All clients will have to update the API access key.')}');" />
								</span>
								<span class="button">
									<g:actionSubmit class="reload" action="regenerateSystemSecretKey" value="${message(code: 'default.button.edit.account.label', default: 'Regenerate secret key')}"
													onclick="return confirm('${message(code: 'default.button.disable.account.confirm.message', default: 'Are you sure you want to regenerate the secret key? All clients will have to update the secret key.')}');" />
								</span>
							</g:form>
						</div>
					</td>
				</tr>
			</tbody>
		</table>

</div>
</div>
