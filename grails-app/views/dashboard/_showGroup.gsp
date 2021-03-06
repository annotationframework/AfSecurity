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
						<label for="privacy">Privacy</label>
					</td>
					<td valign="top" align="left">
						${item?.privacy?.label}
					</td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="status">Status</label>
					</td>
					<td valign="top" align="left">
						${GroupUtils.getStatusLabel(item)}
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="buttons">
							<g:form>
								<g:hiddenField name="id" value="${item?.id}" /> 
								<g:hiddenField name="redirect" value="listGroups" />
								<span class="button">
									<g:actionSubmit class="edit" action="editGroup" value="${message(code: 'default.button.edit.account.label', default: 'Edit group')}" />
								</span>
							</g:form>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
</div>
</div>
