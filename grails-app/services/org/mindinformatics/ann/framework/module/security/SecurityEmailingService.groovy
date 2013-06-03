package org.mindinformatics.ann.framework.module.security

class SecurityEmailingService {

	def mailService;
	def grailsApplication;
	
	def sendAccountRequestConfirmation(def appBase, def userSignupCommand) {
		log.info('Sending confirmation email to ' + userSignupCommand.username)
		mailService.sendMail {
			to userSignupCommand.email
			subject "Confirmation of Domeo account creation"
			html "Dear " + userSignupCommand.firstName + ", <br/>"+
				" your account has been created and it is waiting to be activated by an administrator. <br/><br/>" +
				"You will receive an email when the activation process is completed." +
				"<br/><br/>Sincerely, <br/> "+ grailsApplication.config.domeo.administrator + "<br/>" +
				" The Domeo Annotation Tool team";
		}
	}
	
	def sendAccountConfirmation(def appBase, def accountRequest) {
		log.info('Sending confirmation email to ' + accountRequest.username)
		mailService.sendMail {
			to accountRequest.email
			subject "Domeo account activated"
			html "Dear " + accountRequest.firstName + ", <br/>"+
				" your account has been activated.<br/><br/>" +
				"Please contact us if you experience login issues." +
				"<br/><br/>Sincerely, <br/> "+ grailsApplication.config.domeo.administrator + "<br/>" +
				" The Domeo Annotation Tool team";
		}
	}
	
	def sendApprovalRequest(def appBase, def userSignupCommand) {
		log.info('Sending approval request email for ' + userSignupCommand.email)
		mailService.sendMail {
			to grailsApplication.config.domeo.admin.email.to
			subject "New user request awaiting for confirmation"
			html "<b>Dear Paolo,</b> a new user request by " + userSignupCommand.email + "is awaiting for confirmation"
		}
	}
}
