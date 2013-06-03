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
package org.mindinformatics.ann.framework.module.dashboard;

import org.mindinformatics.ann.framework.module.security.users.Role
import org.mindinformatics.ann.framework.module.security.users.User
import org.mindinformatics.ann.framework.module.security.users.UserRole
import org.mindinformatics.ann.framework.module.security.utils.DefaultUsersRoles

/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
public class AdministratorController extends DashboardController {

	/**
	 * Sends to the main dashboard page that is similar for all the available roles.
	 * The page displays the different tools available to the different roles.
	 * Pushes
	 * - loggedUser: used for passing the current user in a uniform way
	 */
	def index = {
		println 'redirect'
		redirect(action: 'dashboard', mapping: "/dashboard")
	}
	
	def dashboard = {
		def loggedUser = injectUserProfile()
		
		if(loggedUser!=null) 
			render (view:'/administrator/administratorHome',model:[loggedUser: loggedUser]);
	}
	 
	def listUsers = {
		def user = injectUserProfile()

		if (!params.max) params.max = 10
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "username"
		if (!params.order) params.order = "asc"

		def users = usersUtilsService.listUsers(user, params.max, params.offset, params.sort, params.order);

		render (view:'listUsers', model:[user: user, "users" : users, "usersTotal": User.count(), "usersroles": UserRole.list(), "roles" : Role.list(), "menuitem" : "listUsers"])
	}
	
	def createUser = {
		render (view:'createUser',  model:[action: "create", roles: Role.list(), defaultRole: DefaultUsersRoles.USER, "menuitem" : "createUser"]);
	}
	
	def saveUser = {UserCreateCommand userCreateCmd->
		println 'sssssssssssssaving?'
		if(userCreateCmd.hasErrors()) {
			println 'eeeeesssssssssssaving?'
			userCreateCmd.errors.allErrors.each { println it }
			render(view:'createUser', model:[item:userCreateCmd, roles: Role.list(),
						defaultRole: Role.findByAuthority("ROLE_USER")])
		} else {
			println '11sssssssssssssaving?'
			def user = userCreateCmd.createUser()
			if(user)  {
				println '22sssssssssssssaving?'
				if(!user.save()) {
					println 'eesssssssssssssaving?'
					// Failure in saving
					user.errors.allErrors.each { println it }
					render(view:'createUser', model:[item:userCreateCmd, roles: Role.list(),
								msgError: 'The user has not been saved successfully'])
				} else {
					println '33sssssssssssssaving?'
					updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.ADMIN.value()), params.Administrator)
					updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.MANAGER.value()), params.Manager)
					updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.USER.value()), params.User)
					println '44sssssssssssssaving?'
					redirect (action:'showUser',id: user.id, model: [
								msgSuccess: 'The user has not been saved successfully']);
				}
			} else {
				// User already existing
				render(view:'createUser', model:[item:userCreateCmd, roles: Role.list(),
							msgError: 'A user with this name is already existing'])
			}
		}
	}
	
	def editUser = {
		def user = User.findById(params.id)

		render (view:'/shared/editUser', model:[item: user, userRoles: getUserRoles(user), roles: Role.list(), userGroups: getUserGroups(user), action: "edit",
					groupRoles: listOfGroupRoles(), groupStatus: listOfUserGroupStatus()])
	}
	
	def updateUser = { UserEditCommand userEditCmd ->
		if(userEditCmd.hasErrors()) {
			userEditCmd.errors.allErrors.each { println it }
			render(view:'/shared/editUser', model:[item:userEditCmd])
		} else {
			def user = User.findById(params.id)
			user.title = userEditCmd.title
			user.firstName = userEditCmd.firstName
			user.middleName = userEditCmd.middleName
			user.lastName = userEditCmd.lastName
			user.displayName = userEditCmd.displayName
			user.email = userEditCmd.email
			user.affiliation = userEditCmd.affiliation
			user.country = userEditCmd.country
			

			updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.ADMIN.value()), params.Administrator)
			updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.MANAGER.value()), params.Manager)
			updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.USER.value()), params.User)

			updateUserStatus(user, params.status)

			render (view:'/dashboard/showUser', model:[user: user, userRoles: getUserRoles(user),
				appBaseUrl: request.getContextPath()])
		}
	}
}