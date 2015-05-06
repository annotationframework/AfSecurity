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
							<g:textField name="name" size="100"
								value="${item?.name}" class="${hasErrors(bean: item, field: 'name', 'fieldError')}"/>
						</div>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.name!=null}">
							<g:renderErrors bean="${item}" field="name" />
						</g:if> 
						<g:else>
				        	(max 255 chars)
				        </g:else>
				    </td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name">
						<label for="shortName">Short Name</label>
					</td>
					<td valign="top" class="value">
						<g:textField name="shortName" size="100"
							value="${item?.shortName}" class="${hasErrors(bean: item, field: 'shortName', 'fieldError')}"/>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.shortName!=null}">
							<g:renderErrors bean="${item}" field="shortName" />
						</g:if> 
						<g:else>
			           		(max 100 chars)
			            </g:else>
			        </td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name">
						<label for="apikey">API key</label>
					</td>
					<td valign="top" class="value">
						<g:textField name="apikey" size="100"
									 value="${item?.apikey}" class="${hasErrors(bean: item, field: 'apikey', 'fieldError')}"/>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.apikey!=null}">
							<g:renderErrors bean="${item}" field="apikey" />
						</g:if>
						<g:else>
							(max 100 chars)
						</g:else>
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name">
						<label for="shortName">Secret Key</label>
					</td>
					<td valign="top" class="value">
						<g:textField name="secretKey" size="100"
									 value="${item?.secretKey}" class="${hasErrors(bean: item, field: 'secretKey', 'fieldError')}"/>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.shortName!=null}">
							<g:renderErrors bean="${item}" field="secretKey" />
						</g:if>
						<g:else>
							(max 100 chars)
						</g:else>
					</td>
				</tr>


				<tr class="prop">
					<td valign="top" class="name">
						<label for="description">Description</label>
					</td>
					<td valign="top" class="value">
						<g:textArea name="description" cols="100" rows="6"
							value="${item?.description}"  class="${hasErrors(bean: item, field: 'description', 'fieldError')}"/>
					</td>
					<td valign="top" class="caption">
						<g:if test="${item?.description!=null}">
							<g:renderErrors bean="${item}" field="description" />
						</g:if> 
						<g:else>
			           		(max 1024 chars)
			            </g:else>
			        </td>
				</tr>
				<tr>
					<td valign="top"  align="left">
						<label for="description">Created by</label>
					</td>
					<td valign="top" align="left">
						<g:if test="${item?.createdBy}">
							<g:link action="showUser" id="${item?.createdBy?.id}">${item?.createdBy?.displayName}</g:link>
							<g:hiddenField name="createdBy.id" value="${item?.createdBy?.id}"/>
						</g:if>
						<g:else>
							<g:link action="showUser" id="${loggedUser?.id}">${loggedUser?.displayName}</g:link>
							<g:hiddenField name="createdBy.id" value="${loggedUser?.id}"/>
						</g:else>
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name">
						<label for="description">Enabled?</label>
					</td>
					<td valign="top" colspan="2" class="value">

						<g:if test="${action=='create'}">
							<g:checkBox name="enabled" value="${item?.enabled?:true}" />
						</g:if>
						<g:else>

							<g:checkBox name="enabled" value="${item?.enabled}" />
						</g:else>
			        </td>
				</tr>
			</tbody>
		</table>
	</td>
</tr>
