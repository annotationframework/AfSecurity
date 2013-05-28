<%-- by Paolo Ciccarese --%>
<%-- 
Parameters list
 1) item | instance of GroupCreateCommand
Stylesheet
 1) fieldError | background and font color in erroneous text fields
--%>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.GroupUtils" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultGroupStatus" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultGroupPrivacy" %>
<tr>
	<td valign="top">
		<table class="simpleTable">
			<tbody>
				<tr class="prop">
					<td valign="top" width="70px"  class="name">
						<label for="name">Name</label>
					</td>
					<td valign="top" width="255px" class="value">
						<div>
							<g:textField name="name" style="width: 240px;"
								value="${item?.name}" class="${hasErrors(bean: item, field: 'name', 'fieldError')}"/>
						</div>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.name!=null}">
							<g:renderErrors bean="${item}" field="name" />
						</g:if> 
						<g:else>
				        	(max 16 chars)
				        </g:else>
				    </td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name">
						<label for="shortName">Short Name</label>
					</td>
					<td valign="top" class="value">
						<g:textField name="shortName" style="width: 240px;"
							value="${item?.shortName}" class="${hasErrors(bean: item, field: 'shortName', 'fieldError')}"/>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.shortName!=null}">
							<g:renderErrors bean="${item}" field="shortName" />
						</g:if> 
						<g:else>
			           		(max 255 chars)
			            </g:else>
			        </td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name">
						<label for="description">Description</label>
					</td>
					<td valign="top" class="value">
						<g:textField name="description" style="width: 240px;"
							value="${item?.description}"  class="${hasErrors(bean: item, field: 'description', 'fieldError')}"/>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.description!=null}">
							<g:renderErrors bean="${item}" field="description" />
						</g:if> 
						<g:else>
			           		(max 255 chars)
			            </g:else>
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
				<tr class="prop">
					<td valign="top" class="name">
						<label for="description">Status</label>
					</td>
					<td valign="top" colspan="2" class="value">
						<g:if test="${action=='create'}">
							<g:radio name="status" value="${DefaultGroupStatus.ACTIVE.value()}" checked="checked"/> Enabled
						</g:if>
						<g:else>
							<g:if test="${item?.enabled==true}">
								<g:radio name="status" value="item?.enabled" checked="checked"/> Enabled
								<g:radio name="status" value="item?.enabled" /> Disabled
							</g:if>
							<g:else>
								<g:radio name="status" value="item?.enabled"/> Enabled
								<g:radio name="status" value="item?.enabled" checked="checked"/> Disabled
							</g:else>
						</g:else>
			        </td>
				</tr>
			</tbody>
		</table>
	</td>
</tr>
