
<%-- by Paolo Ciccarese --%>
<%-- Parameters list
 1) item | instance of UserCreateCommand
 2) error | errors in text format
--%>
<!-- Begin signup form -->
<style>
div.public-formbox {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
	background: #fff;
	padding: 15px;
}

.public-formbox-inner {
	width: 450px;
	border: 3px #FFCC00 solid;
	background: #fff;
	height: 140px;
}

.public-formbox-inner table {
	border: 0px;
}

td.public-formbox-title {
	
	background: #FFCC00;
	border-bottom: 1px #cc3300 solid;
	color: #000;
	padding: 0;
	padding-left: 10px;
	padding-right: 10px;
	height: 18px;
	padding-top: 10px;
	height: 20px;
}

td.public-formbox-title table {
	width: 100%;
	font-size: 16px;
	border: 0;
}

table.public-formbox-inner  td {
	border: 0;
}
</style>
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
                <%--
                <g:render template="/dashboard/accountRequestForm" plugin="domeo-dashboard" />
                <g:render template="/public/accountFields" plugin="domeo-dashboard" />
                --%>
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