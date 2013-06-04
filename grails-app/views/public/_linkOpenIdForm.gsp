<%-- by Paolo Ciccarese --%>
<!-- Begin signup form -->
<div id='public-formbox'>
 	<g:if test='${flash.message}'><div class='login_message'>${flash.message}</div></g:if>
	<g:form method="post" controller="OpenId">
		<table style="width: 800px;" class='public-formbox-inner'>
         	<tr>
				<td class="public-formbox-title">
					<table>
						<tr>
							<td align="left">Sign Up for ${grailsApplication.config.af.shared.name} v. <g:meta name="app.version"/> </td>
							<td align="right" class="openid-loginbox-useopenid"></td>
						</tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2">
                    <g:if test="${msgError!=null}">${msgError}</g:if>
                    <g:else><!-- No Errors --></g:else>
                </td>
            </tr>
            <tr>
				<td valign="top">
					<table>
						<tbody>
							<tr>
								<td>Open ID:</td>
								<td><span id='openid'>${openId}</span></td>
							</tr>
							<tr>
								<td><label for='username'>Username:</label></td>
								<td><g:textField name='username' value='${command?.username}'/></td>
							</tr>
							<tr>
								<td><label for='password'>Password:</label></td>
								<td><g:passwordField name='password' value='${command?.password}'/></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
            <tr>
				<td valign="top" colspan="2" >
					<div id='openidLogin' align="center">
 						<div class="buttons">
							<span class="button">
								<g:actionSubmit class="save" action="linkAccount" value="${message(code: 'default.button.edit.account.label', default: 'Link account')}" />
							</span>
						</div>     
                    </div>
                </td>
            </tr>
		</table>
	</g:form>
</div>
<!-- End signup form -->