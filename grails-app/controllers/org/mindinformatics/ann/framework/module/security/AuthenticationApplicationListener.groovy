package org.mindinformatics.ann.framework.module.security

import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.InteractiveAuthenticationSuccessEvent
import org.springframework.stereotype.Component

@Component
class AuthenticationApplicationListener implements ApplicationListener<InteractiveAuthenticationSuccessEvent> {

  @Override
  void onApplicationEvent(InteractiveAuthenticationSuccessEvent event) {
	  println 'Detected authentication ' + event.generatedBy;
  }

}