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
class UserEditCommand {

	def springSecurityService;
	
	public static final Integer NAME_MAX_SIZE = 255;
	
	// Users status values
	//---------------------
	String status
	
	//Users' data
	String title
	String firstName
	String middleName
	String lastName
	String displayName
	String email
	String affiliation
	String country
	
	//Account credentials
	String id
	String username
	
	static constraints = {
		//Users' data
		title (nullable: true, blank: true, maxSize:NAME_MAX_SIZE)
		firstName (blank: false, maxSize:NAME_MAX_SIZE)
		middleName (nullable: true, blank: true, maxSize:NAME_MAX_SIZE)
		lastName (blank: false, maxSize:NAME_MAX_SIZE)
		displayName (blank: true, maxSize:NAME_MAX_SIZE)
		email (blank: false, email: true,  maxSize:NAME_MAX_SIZE)
		affiliation (blank: true, maxSize:NAME_MAX_SIZE)
		country (blank: true, maxSize:NAME_MAX_SIZE)
		//Account credentials
		id (blank: false)
		username (blank: false, maxSize:NAME_MAX_SIZE)
	}
	
	boolean isEnabled() {
		return status.equals(UserStatus.ACTIVE_USER.value());
	}
	
	boolean isDisabled() {
		return status.equals(UserStatus.DISABLED_USER.value());
	}
	
	boolean isCreated() {
		return status.equals(UserStatus.CREATED_USER.value());
	}
	
	boolean isLocked() {
		return status.equals(UserStatus.LOCKED_USER.value());
	}
}
