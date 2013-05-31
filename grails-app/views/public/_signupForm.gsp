<%-- by Paolo Ciccarese --%>
<!-- Begin signup form -->
<div id='public-formbox'>
    <div>
        <g:if test='${flash.message}'><div class='login_message'>${flash.message}</div></g:if>
        <form method="post" >
            <table style="width: 900px;" class='public-formbox-inner'>
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
                <g:render template="/public/accountRequestForm"/>
                <g:render template="/public/accountFields"/>
                <tr>
                    <td valign="top" colspan="2" >
                        <div id='openidLogin' align="center">
                            <div class="buttons">
                                <span class="button">
                                    <g:actionSubmit class="save" action="saveAccountRequest" value="${message(code: 'default.button.edit.account.label', default: 'Sign Up*')}" />
                                </span>
                            <div>
                            * Means agreeing with below terms and conditions
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!-- End signup form -->