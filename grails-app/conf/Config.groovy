// configuration for plugin testing - will not be included in the plugin zip

log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

    warn   'org.mortbay.log'
	
	info    'grails.app', // Necessary for Bootstrap logging
			'org.springframework.security'
	
	//debug 'org.springframework.security'
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'org.mindinformatics.ann.framework.module.security.users.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'org.mindinformatics.ann.framework.module.security.users.UserRole'
grails.plugins.springsecurity.authority.className = 'org.mindinformatics.ann.framework.module.security.users.Role'
grails.plugins.springsecurity.rememberMe.persistent = true
grails.plugins.springsecurity.rememberMe.persistentToken.domainClassName = 'org.mindinformatics.ann.framework.module.security.PersistentLogin'

grails.plugins.springsecurity.openid.domainClass = 'org.mindinformatics.ann.framework.module.security.OpenID'
