<%@ page import="org.mindinformatics.ann.framework.module.security.utils.GroupUtils" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultGroupStatus" %>
<%@ page import="org.mindinformatics.ann.framework.module.security.utils.DefaultGroupPrivacy" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="administrator-dashboard" />
    <title>Edit System: ${item?.name} :: ${grailsApplication.config.af.shared.title}</title>
</head>
<body>
<div class="title">
    <img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'computer-edit.png',plugin:'af-security')}"/>
    Generate Token: ${system?.name}
</div>
<div class="sectioncontainer">
    <g:form method="post" action="generateToken" controller="dashboard">
        <div class="dialog" >
            <g:hiddenField name="id" value="${system?.id}" />
            <table class="simpleTableNoBorder" style="width: 800px">
                <tr>
                    <td valign="top" colspan="2">
                        <g:if test="${msgError!=null}">
                            ${msgError}
                        </g:if>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <table class="simpleTable">
                            <tbody>
                                <tr class="prop">
                                    <td valign="top" width="70px"  class="name">
                                        <label for="apikey">API key</label>
                                    </td>
                                    <td valign="top" class="value">
                                        <div>
                                            <g:textField name="apikey" size="100"
                                                         value="${params?.apiKey?:system?.apikey}" class="${hasErrors(bean: system, field: 'apikey', 'fieldError')}"/>
                                        </div>
                                    </td>

                                </tr>
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="secretKey">Secret Key</label>
                                    </td>
                                    <td valign="top" class="value">
                                        <g:textField name="secretKey" size="100"
                                                     value="${params?.secretKey?:system?.secretKey}" class="${hasErrors(bean: system, field: 'secretKey', 'fieldError')}"/>
                                    </td>

                                </tr>
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="username">Username</label>
                                    </td>
                                    <td valign="top" class="value">
                                        <g:textField name="username" size="100"
                                                     value="${params.username?:user?.username}" class="${hasErrors(bean: user, field: 'username', 'fieldError')}"/>
                                    </td>

                                </tr>
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="ttl">TTL</label>
                                    </td>
                                    <td valign="top" class="value">
                                        <g:textField name="ttl" size="100"
                                                     value="${params?.ttl?:86400}" class="${hasErrors(bean: system, field: 'ttl', 'fieldError')}"/>
                                    </td>
                                </tr>
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="token">Token</label>
                                    </td>
                                    <td valign="top" class="value">
                                        <g:textArea name="token" cols="100" rows="6" class="${hasErrors(bean: system, field: 'token', 'fieldError')}" readonly="readonly">${token}</g:textArea>
                                        NOTE: You can test the token by copying the value above and pasting it in the token field on <a href="http://jwt.io" target="_blank">jwt.io</a>.
                                    </td>
                                </tr>
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="token">Search API</label>
                                    </td>
                                    <td valign="top" class="value">
                                        <g:set var="baseUrl" value="${grailsApplication.config.grails.serverURL?:"http://localhost:8080"}"/>
                                        <g:textArea name="token"
                                                    cols="100" rows="6" readonly="readonly">curl -i -X GET -H "Content-Type: application/json" -H "x-annotator-auth-token:${token}" "${baseUrl}/catch/annotator/search?limit=10"</g:textArea>

                                        <g:if test="${!grailsApplication.config.grails.serverURL}">
                                            NOTE: To change the base URL in the above cURL command, you need to add the following property to your <b>catch-config.properties</b> file.

                                            <pre>grails.serverURL = http://www.example.com</pre>
                                        </g:if>
                                    </td>
                                </tr>




                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td valign="top" colspan="2">
                        <div class="buttons">
                            <span class="button">
                                <g:actionSubmit class="save" action="generateToken" id="${system?.id}" value="${message(code: 'default.button.generate.token.label', default: 'Generate token')}" />
                            </span>
                            <span class="button">
                                <g:actionSubmit class="cancel" action="showSystem" id="${system?.id}" value="${message(code: 'default.button.edit.account.label', default: 'Cancel')}" />
                            </span>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </g:form>
</div>


</body>
</html>