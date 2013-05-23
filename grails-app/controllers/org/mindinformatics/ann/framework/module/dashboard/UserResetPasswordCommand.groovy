/*
 * Copyright 2013 Massachusetts General Hospital
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.mindinformatics.ann.framework.module.dashboard

import grails.validation.Validateable


/**
* Object command for User validation and creation.
*
* @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
*/
@Validateable
class UserResetPasswordCommand {

	def springSecurityService;
	
	public static final Integer NAME_MAX_SIZE = 255;

	//Account credentials
	String password
	String passwordConfirmation
	
	static constraints = {
		//Account credentials
		password (blank: false, minSize:6, maxSize:NAME_MAX_SIZE)
		passwordConfirmation (blank: false, minSize:6, maxSize:NAME_MAX_SIZE)
	}
	
	
	boolean isPasswordValid() {
		return password.equals(passwordConfirmation);
	}	
}
