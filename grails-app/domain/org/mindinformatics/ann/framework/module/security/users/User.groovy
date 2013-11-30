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
package org.mindinformatics.ann.framework.module.security.users

import java.util.Date;
import org.mindinformatics.ann.framework.module.security.OpenID

/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
class User {

	private static final int NAME_MAX_SIZE = 255;
	
	String id
	String username
	String password
	
	// User's data
	String email
	String title
	String firstName
	String middleName
	String lastName
	String displayName
	String country
	String affiliation
	
	Date dateCreated, lastUpdated
	
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	
	static hasMany = [openIds: OpenID]

	static constraints = {
		id maxSize: 36
		email blank: false, unique: true, email: true
		username blank: false, unique: true
		password blank: false
		
		//User's data
		title (nullable: true, blank: true, maxSize:NAME_MAX_SIZE)
		firstName (blank: false, maxSize:NAME_MAX_SIZE)
		middleName (nullable: true, blank: true, maxSize:NAME_MAX_SIZE)
		lastName (blank: false, maxSize:NAME_MAX_SIZE)
		displayName (blank: false, maxSize:NAME_MAX_SIZE)
		affiliation (nullable: true, blank: true, maxSize:NAME_MAX_SIZE)
		country (nullable: true, blank: true, maxSize:NAME_MAX_SIZE)
	}

	static mapping = {
		password column: '`password`'
		id generator:'uuid', sqlType: "varchar(36)"
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

    String toString() {
        return "${firstName} ${lastName} - ${username} - ${email}"
    }

}
