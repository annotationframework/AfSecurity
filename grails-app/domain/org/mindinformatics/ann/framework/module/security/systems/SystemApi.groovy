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
package org.mindinformatics.ann.framework.module.security.systems

import grails.validation.Validateable

import org.mindinformatics.ann.framework.module.security.groups.Group
import org.mindinformatics.ann.framework.module.security.users.User

/**
* @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
*/
@Validateable
class SystemApi {

	String id;
	String name;
	String shortName;
	String description;
	
	User createdBy;
	Date dateCreated, lastUpdated
	
	/**
	 * Api key to be used by the external application to get to the
	 * annotation framework node data.
	 */
	String apikey;

	String secretKey

	/**
	 * System access can be disabled.
	 */
	boolean enabled
	
	/**
	 * If true it allows the external application to get to all the 
	 * public data of the annotation framework node.
	 */
	boolean accessToPublicData
	/**
	 * Grants access to the data belonging to specified groups and
	 * users.
	 */
	static hasMany = [groups: Group, users: User]
	
	String getUri() {
		return "urn:group:uuid:"+id;
	}
	
	static mapping = {
		id generator:'uuid', sqlType: "varchar(36)"
	}
	
	static constraints = {
		id maxSize: 36
		
		apikey (nullable:false, blank: false, unique: true, maxSize:255)
		secretKey (nullable:true, maxSize: 255)
		name (nullable:false, blank: false, maxSize:255)
		shortName  (nullable:true, blank: true, maxSize:100)
		description (nullable:false, blank:true, maxSize:1024)
	}
}
