
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

import grails.converters.JSON

import org.mindinformatics.ann.framework.module.security.OpenID
import org.mindinformatics.ann.framework.module.security.groups.Group
import org.mindinformatics.ann.framework.module.security.groups.UserGroup
import org.mindinformatics.ann.framework.module.security.systems.SystemApi
import org.mindinformatics.ann.framework.module.security.systems.UserSystemApi
import org.mindinformatics.ann.framework.module.security.users.User


/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
class AjaxDashboardController {

	// GROUPS
	//--------------------------------
	/*
	 * Pass through method that extracts the id parameter
	 * of the user and returns hers UserGroup entities.
	 */
	def userGroups = {
		return getUserGroups(User.findById(params.id));
	}
	
	/*
	 * This returns UserGroup entities as that makes possible
	 * retrieving the details for this relationship and both
	 * the user and the group data
	 */
	def getUserGroups(def user) {
		def userGroups = []
		userGroups = UserGroup.findAllByUser(user)
		JSON.use("deep")
		render userGroups as JSON;
	}
	
	def userAdministeredSystems() {
		return getUserAdministeredSystems(User.findById(params.id));
	}
	
	def getUserAdministeredSystems(def user) {
		def systems = UserSystemApi.findAllByUser(user);
		JSON.use("deep")
		render systems as JSON;
	}
	
	def groupUsers = {
		return getGroupUsers(Group.findById(params.id));
	}
	
	def getGroupUsers(def group) {
		def groupUsers = []
		groupUsers = UserGroup.findAllByGroup(group)
		JSON.use("deep")
		render groupUsers as JSON;
	}
	
	def userOpenIds = {
		getUserOpenIds(User.findById(params.id));
	}
	
	def getUserOpenIds(def user) {
		def ids = OpenID.findAllByUser(user);
		JSON.use("deep")
		render ids as JSON;
	}
	
	// SYSTEMS
	//--------------------------------
	/*
	 * Pass through method that extracts the id parameter
	 * of the user and returns hers UserGroup entities.
	 */
	def systemGroups = {
		def system = SystemApi.findById(params.id)
		
		JSON.use("deep")
		render system.groups as JSON;
	}
	
	def systemAdministrators = {
		def system = SystemApi.findById(params.id)
		def userSystem = UserSystemApi.findAllBySystem(system);
		
		JSON.use("deep")
		render userSystem as JSON;
	}
	
	def systemUsers = {
		def system = SystemApi.findById(params.id)
		
		JSON.use("deep")
		render system.users as JSON;
	}
	

}
