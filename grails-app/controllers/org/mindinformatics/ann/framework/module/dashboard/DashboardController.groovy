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

import grails.converters.JSON

import org.mindinformatics.ann.framework.module.security.groups.Group
import org.mindinformatics.ann.framework.module.security.groups.GroupPrivacy
import org.mindinformatics.ann.framework.module.security.groups.GroupRole
import org.mindinformatics.ann.framework.module.security.groups.UserGroup
import org.mindinformatics.ann.framework.module.security.groups.UserStatusInGroup
import org.mindinformatics.ann.framework.module.security.systems.SystemApi
import org.mindinformatics.ann.framework.module.security.systems.UserSystemApi
import org.mindinformatics.ann.framework.module.security.users.Role
import org.mindinformatics.ann.framework.module.security.users.User
import org.mindinformatics.ann.framework.module.security.users.UserRole
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupPrivacy
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupRoles
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupStatus
import org.mindinformatics.ann.framework.module.security.utils.DefaultUserStatusInGroup
import org.mindinformatics.ann.framework.module.security.utils.DefaultUsersRoles
import org.mindinformatics.ann.framework.module.security.utils.GroupUtils
import org.mindinformatics.ann.framework.module.security.utils.UserStatus
import org.mindinformatics.ann.framework.module.security.utils.UserUtils


/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
public class DashboardController {

	def springSecurityService
	def usersUtilsService
	
	/*
	 * Loading by primary key is usually more efficient because it takes 
	 * advantage of Hibernate's first-level and second-level caches 
	 */
	protected def injectUserProfile() {
		def principal = springSecurityService.principal
		if(principal.equals("anonymousUser")) {
			redirect(controller: "login", action: "index");
		} else {
			String userId = principal.id
			def user = User.findById(userId);
			if(user==null) {
				log.error "Error:User not found for id: " + userId
				render (view:'error', model:[message: "User not found for id: "+userId]);
			}
			user
		}
	}
	
	/**
	 * Sends to the main dashboard page that is similar for all the available roles.
	 * The page displays the different tools available to the different roles.
	 * Pushes
	 * - loggedUser: used for passing the current user in a uniform way
	 */
	def index = {
		def loggedUser = injectUserProfile();	
		if(loggedUser!=null) {
			render (view:'home', model:[loggedUser: loggedUser]);
		} else {
			render (view:'error', model:[message: "Logged user not found"]);
		}
	}	 
	
	// =======================================================================
	//   USERS MANAGEMENT
	// =======================================================================
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
		def user = injectUserProfile()
		render (view:'createUser',  model:[action: "create", roles: Role.list(), defaultRole: DefaultUsersRoles.USER, "menuitem" : "createUser"]);
	}
	
	def editUser = {
		def user = User.findById(params.id)

		render (view:'editUser', model:[item: user, userRoles: getUserRoles(user), roles: Role.list(), userGroups: getUserGroups(user), action: "edit",
					groupRoles: listOfGroupRoles(), groupStatus: listOfUserGroupStatus()])
	}
	
	def listRoles = {
		def user = injectUserProfile()

		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "authority"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listRoles(user, params.max, params.offset, params.sort, params.order);

		render (view:'listRoles', model:[user : user, "roles" : results[0], "rolesTotal": Role.count(), "rolesCount": results[1], "menuitem" : "listRoles"])
	}
	
	def performSarchUser = {
		def user = injectUserProfile()

		if (!params.max) params.max = 1
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "username"
		if (!params.order) params.order = "asc"

		//TODO fix pagination
		def users = [];
		if (params.sort == 'status') {
			def buffer = [];
			def usersStatus = [:]
			User.list().each { auser ->
				usersStatus.put (auser.id, auser.status)
			}
			usersStatus = usersStatus.sort{ a, b -> a.value.compareTo(b.value) }
			if(params.order == "desc")
				usersStatus.each { userStatus ->
					buffer.add(User.findById(userStatus.key));
				}
			else
				usersStatus.reverseEach { userStatus ->
					buffer.add(User.findById(userStatus.key));
				}

			int offset = (params.offset instanceof String) ? Integer.parseInt(params.offset) : params.offset
			int max = (params.max instanceof String) ? Integer.parseInt(params.max) : params.max
			for(int i=offset;i< Math.min(offset+max, usersStatus.size()); i++) {
				users.add(buffer[i]);
			}
		} else if (params.sort == 'isAdmin' || params.sort == 'isAnalyst' || params.sort == 'isManager'
		|| params.sort == 'isCurator' || params.sort == 'isUser') {

		} else if (params.sort == 'name') {
			def buffer = [];
			def usersNames = [:]
			User.list().each { auser ->
				usersNames.put (auser.id, auser.name)
			}
			usersNames = usersNames.sort{ a, b -> a.value.compareTo(b.value) }
			if(params.order == "desc")
				usersNames.each { userName ->
					buffer.add(User.findById(userName.key));
				}
			else
				usersNames.reverseEach { userName ->
					buffer.add(User.findById(userName.key));
				}
			int offset = (params.offset instanceof String) ? Integer.parseInt(params.offset) : params.offset
			int max = (params.max instanceof String) ? Integer.parseInt(params.max) : params.max
			for(int i=offset;i< Math.min(offset+max, usersNames.size()); i++) {
				users.add(buffer[i]);
			}
		} else {
			// Search with no ordering
			def userStatusCriteria = User.createCriteria();
			def r = [];
			if(params.firstName!=null && params.firstName.trim().length()>0 &&
			params.lastName!=null && params.lastName.trim().length()>0) {
				r = userStatusCriteria.list {
					maxResults(params.max?.toInteger())
					firstResult(params.offset?.toInteger())
					order(params.sort, params.order)
					and {
						like('firstName', params.firstName)
						like('lastName', params.lastName)
					}
				}
			} else if(params.firstName!=null && params.firstName.trim().length()>0 &&
			(params.lastName==null || params.lastName.trim().length()==0)) {
				r = userStatusCriteria.list {
					maxResults(params.max?.toInteger())
					firstResult(params.offset?.toInteger())
					order(params.sort, params.order)
					like('firstName', params.firstName)
				}
			} else if((params.firstName==null || params.firstName.trim().length()==0) &&
			params.lastName!=null &&  params.lastName.trim().length()>0) {
				r = userStatusCriteria.list {
					maxResults(params.max?.toInteger())
					firstResult(params.offset?.toInteger())
					order(params.sort, params.order)
					like('lastName', params.lastName)
				}
			} else if(params.displayName!=null && params.displayName.trim().length()>0) {
				r = userStatusCriteria.list {
					maxResults(params.max?.toInteger())
					firstResult(params.offset?.toInteger())
					order(params.sort, params.order)
					like('displayName', params.displayName)
				}
			}
			users = r.toList();
		}

		def usersResults = []
		users.each { userItem ->
			def roles = UserRole.findAllByUser(userItem);
			def userResult = [id:userItem.id, username:userItem.username, name: userItem.firstName + " " + userItem.lastName,
						displayName: userItem.getDisplayName(),
						isAdmin: roles.role.authority.contains(DefaultUsersRoles.ADMIN.value()), isManager: roles.role.authority.contains(DefaultUsersRoles.MANAGER.value()), 
						isUser: roles.role.authority.contains(DefaultUsersRoles.USER.value()), email: userItem.getEmail(),
						status: UserUtils.getStatusLabel(userItem), dateCreated: userItem.dateCreated]
			usersResults << userResult
		}

		def paginationResults = ['offset':params.offset+params.max, 'sort':params.sort, 'order':params.order]


		def results = [users: usersResults, pagination: paginationResults]
		render results as JSON
	}
	
	def showUser = {
		if(params.id!=null) {
			def user = User.findById(params.id);
			if(user!=null) {
				render (view:'/dashboard/showUser', model:[user: user,
						userRoles: usersUtilsService.getUserRoles(user),
						userGroups: usersUtilsService.getUserGroups(user),
						userCircles: usersUtilsService.getUserCircles(user),
						userCommunities: usersUtilsService.getUserCommunities(user),
						appBaseUrl: request.getContextPath()
					]);
			} else {
				render (view:'/error', model:[message: "User not found for id: "+params.id]);
			}
		} else {
			render (view:'/error', model:[message: "User id not defined!"]);
		}
	}
	
	def searchUser = {
		render (view:'searchUser', model:["menuitem" : "searchUser"]);
	}
	
	def lockUser = {
		def user = User.findById(params.id)
		user.accountLocked = true
		user.enabled = true;
		if(params.redirect)
			redirect(action:params.redirect, params:[id: params.id])
		else
			redirect(action:'showUser', params:[id: params.id])
			//render (view:'showProfile', model:[user: user])
	}

	def unlockUser = {
		def user = User.findById(params.id)
		user.accountLocked = false
		user.enabled = true;
		if(params.redirect)
			redirect(action:params.redirect, params:[id: params.id])
		else
			redirect(action:'showUser', params:[id: params.id])
	}

	def enableUser = {
		def user = User.findById(params.id)
		user.enabled = true
		user.accountLocked = false
		if(params.redirect)
			redirect(action:params.redirect, params:[id: params.id])
		else
			redirect(action:'showUser', params:[id: params.id])
	}

	def disableUser = {
		def user = User.findById(params.id)
		user.enabled = false
		user.accountLocked = false
		if(params.redirect)
			redirect(action:params.redirect, params:[id: params.id])
		else
			redirect(action:'showUser', params:[id: params.id])
	}
	
	def resetUserPassword = {
		def user = User.findById(params.user)
		
		render (view:'resetUserPassword', model: [user: user]);
	}
	
	def saveUserPassword = {UserResetPasswordCommand userResetPasswordCommand->
		def user = User.findById(params.user)
		if(userResetPasswordCommand.hasErrors()) {
			userResetPasswordCommand.errors.allErrors.each { println it }
			render(view:'resetUserPassword', model:[user: user, item:userResetPasswordCommand,
				,msgError: 'The password has not been saved successfully'])
		} else {
			user.password = springSecurityService.encodePassword(userResetPasswordCommand.password);
			
			redirect (action:'showUser',id: user.id, model: [
						msgSuccess: 'Passowrd saved successfully']);
		}
	}
	
	def addAdministratorsToSystem = {
		def system = SystemApi.findById(params.id)
		render (view:'addAdministratorsToSystem', model:["menuitem" : "searchGroup", system: system,
			appBaseUrl: request.getContextPath()]);
	}
	
	def addAdministratorToSystem = {
		def system = SystemApi.findById(params.system)
		def user = User.findById(params.user);
		
		if(UserSystemApi.findByUserAndSystem(user, system)==null) 
			UserSystemApi.create(user, system)

		redirect (action:'showSystem', id: system.id);
	}
	
	def addGroupsToSystem = {
		def system = SystemApi.findById(params.id)
		render (view:'addGroupsToSystem', model:["menuitem" : "searchGroup", system: system,
			appBaseUrl: request.getContextPath()]);
	}
	
	def addGroupToSystem = {
		def system = SystemApi.findById(params.system)
		def group = Group.findById(params.group);
		
		system.groups.add(group);
		
		redirect (action:'showSystem', id: system.id);
	}
	
	def manageGroupsOfSystem = {
		def system = SystemApi.findById(params.id)
		
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listSystemGroups(system, params.max, params.offset, params.sort, params.order);

		render (view:'manageGroupsOfSystem', model:["systemgroups" : results[0], "numbergroups": system.groups.size(), "systemsCount": results[1], "menuitem" : "listGroups", "system": system])
	}
	
	def manageAdministratorsOfSystem = {
		def system = SystemApi.findById(params.id)
		
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listSystemAdministrators(system, params.max, params.offset, params.sort, params.order);

		render (view:'manageAdministratorsOfSystem', model:["systemAdministrators" : results[0], "administratorsCount": results[1], "menuitem" : "listGroups", "system": system])
	}
	
	def regenerateSystemApiKey = {
		def system = SystemApi.findById(params.id)
		
		def key = UUID.randomUUID() as String
		system.apikey = key;
		
		render (view:'showSystem', model:[item: system,
			appBaseUrl: request.getContextPath()])
	}
	
	def listSystems = {
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "systemsCount"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listSystems(params.max, params.offset, params.sort, params.order);

		render (view:'listSystems', model:["systems" : results[0], "systemsTotal": SystemApi.count(), "systemsCount": results[1], "menuitem" : "listSystems",
			appBaseUrl: request.getContextPath()])
	}
	
	def enableSystem = {
		def group = SystemApi.findById(params.id)
		group.enabled = true
		if(params.redirect)
			redirect(action:params.redirect)
		else
			render (view:'showSystem', model:[item: group])
	}

	def disableSystem = {
		def group = SystemApi.findById(params.id)
		group.enabled = false
		if(params.redirect)
			redirect(action:params.redirect)
		else
			render (view:'showSystem', model:[item: group])
	}
	
	def editSystem = {
		def system = SystemApi.findById(params.id)
		render (view:'editSystem', model:[item: system, action: "edit"])
	}

	def updateSystem = { SystemApiEditCommand groupEditCmd ->
		if(groupEditCmd.hasErrors()) {
			/* groupCreateCmd.errors.allErrors.each { println it } */
			render(view:'editGroup', model:[item:groupCreateCmd])
		} else {
			def group = SystemApi.findById(params.id)
			group.name = groupEditCmd.name
			group.shortName = groupEditCmd.shortName
			group.description = groupEditCmd.description

			if(groupEditCmd.enabled) {
				group.enabled = true
			} else  {
				group.enabled = false
			}

			render (view:'showSystem', model:[item: group,
				appBaseUrl: request.getContextPath()])
		}
	}
	
	def searchSystem = {
		render (view:'searchSystem', model:["menuitem" : "searchSystems"]);
	}
	
	def performSystemSearch = {
		def user = injectUserProfile()

		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def groups = [];
		def groupsCount = [:]
		def usersCount = [:]
		def groupsStatus = [:]
		SystemApi.list().each { agroup ->
			usersCount.put (agroup.id, agroup.users.size())
			groupsCount.put (agroup.id, agroup.groups.size())
			groupsStatus.put (agroup.id, (agroup.enabled?"enabled":"disabled"))
		}

		// Search with no ordering
		def groupCriteria = SystemApi.createCriteria();
		def r = [];

		if(params.name!=null && params.name.trim().length()>0 &&
		params.shortName!=null && params.shortName.trim().length()>0) {
			println 'case 1'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
				and {
					like('name', params.name)
					like('shortName', params.shortName)
				}
			}
		} else if(params.name!=null && params.name.trim().length()>0 &&
		(params.shortName==null || params.shortName.trim().length()==0)) {
			println 'case 2'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
				like('name', params.name)
			}
		} else if((params.name==null || params.name.trim().length()==0) &&
		params.shortName!=null &&  params.shortName.trim().length()>0) {
			println 'case 3'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
				like('shortName', params.shortName)
			}
		} else {
			println 'case 4'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
			}
		}
		groups = r.toList();
		//}


		def groupsResults = []
		groups.each { groupItem ->
			def groupResult = [id:groupItem.id, name:groupItem.name, shortName: groupItem.shortName,
						description: groupItem.description, status: (groupItem.enabled?"enabled":"disabled"), dateCreated: groupItem.dateCreated]
			groupsResults << groupResult
		}

		def paginationResults = ['offset':params.offset+params.max, 'sort':params.sort, 'order':params.order]


		def results = [groups: groupsResults, pagination: paginationResults, groupsCount: groupsCount, usersCount: usersCount]
		render results as JSON
	}
	
	def showSystem = {
		def system = SystemApi.findById(params.id)
		render (view:'showSystem', model:[item: system,
			appBaseUrl: request.getContextPath()])
	}
	
	def createSystem = {
		def user = injectUserProfile();
		
		render (view:'createSystem',  model:[action: "create", loggedUser: user,  "menuitem" : "createSystem"]);
	}

	def saveSystem = {SystemApiCreateCommand systemCreateCmd->
		if(systemCreateCmd.hasErrors()) {
			systemCreateCmd.errors.allErrors.each { println it }
			render(view:'createUser', model:[item:systemCreateCmd])
		} else {
			def system = systemCreateCmd.createSystem()
			def user = injectUserProfile();
			system.createdBy = user;
			if(system)  {
				if(!system.save()) {
					// Failure in saving
					system.errors.allErrors.each { println it }
					render(view:'createSystem', model:[item:systemCreateCmd,
								msgError: 'The system has not been saved successfully'])
				} else {
					redirect (action:'showSystem', id: system.id, model: [
								msgSuccess: 'System saved successfully']);
				}
			} else {
				// User already existing
				render(view:'createSystem', model:[item:systemCreateCmd,
							msgError: 'A system with this name is already existing'])
			}
		}
	}
	
	def showGroup = {
		def group = Group.findById(params.id)
		if(group!=null) {
			render (view:'showGroup', model:[item: group,
				appBaseUrl: request.getContextPath()])
		} else redirect(controller: "dashboard", action: "index");
	}
	
	def createGroup = {
		render (view:'createGroup',  model:[action: "create", "menuitem" : "createGroup"]);
	}

	def saveGroup = {GroupCreateCommand groupCreateCmd->
		if(groupCreateCmd.hasErrors()) {
			groupCreateCmd.errors.allErrors.each { println it }
			render(view:'createUser', model:[item:groupCreateCmd, roles: Role.list(),
						defaultRole: Role.findByAuthority("ROLE_USER")])
		} else {
			def group = groupCreateCmd.createGroup()
			if(group)  {
				def user = injectUserProfile();
				group.createdBy = user;
				updateGroupPrivacy(group, groupCreateCmd.privacy);
				updateGroupStatus(group, groupCreateCmd.status);
				println 'lllllll ' + group.id + group.name + group.description + group.privacy+"--"+group.enabled
				if(!group.save()) {
					// Failure in saving
					group.errors.allErrors.each { println it }
					render(view:'/shared/createGroup', model:[item:groupCreateCmd,
								msgError: 'The group has not been saved successfully'])
				} else {
					redirect (action:'showGroup', id: group.id, model: [
								msgSuccess: 'Group saved successfully']);
				}
			} else {
				// User already existing
				render(view:'/shared/createGroup', model:[item:groupCreateCmd,
							msgError: 'A group with this name is already existing'])
			}
		}
	}
	
	def updateGroupPrivacy(def group, def privacy) {
		if(privacy==DefaultGroupPrivacy.PRIVATE.value()) {
			group.privacy = GroupPrivacy.findByValue(DefaultGroupPrivacy.PRIVATE.value());
		} else if(privacy==DefaultGroupPrivacy.RESTRICTED.value()) {
			group.privacy = GroupPrivacy.findByValue(DefaultGroupPrivacy.RESTRICTED.value());
		} else if(privacy==DefaultGroupPrivacy.PUBLIC.value()) {
			group.privacy = GroupPrivacy.findByValue(DefaultGroupPrivacy.PUBLIC.value());
		}
		println 'lllllll ' + group.privacy
	}

	def updateGroupStatus(def group, def status) {
		println 'xxxxxxxxx ' + status
		if(status.equals(DefaultGroupStatus.ACTIVE.value())) {
			group.enabled = true
			group.locked = false
		} else if(status.equals(DefaultGroupStatus.DISABLED.value())) {
			group.enabled = false
			group.locked = false
		} else if(status.equals(DefaultGroupStatus.LOCKED.value())) {
			group.enabled = true
			group.locked = true
		}
	}

	def lockGroup = {
		def group = Group.findById(params.id)
		group.locked = true
		group.enabled = true;
		if(params.redirect)
			redirect(action:params.redirect)
		else
			render (view:'showGroup', model:[item: group])
	}


	def unlockGroup = {
		def group = Group.findById(params.id)
		group.locked = false
		group.enabled = true;
		if(params.redirect)
			redirect(action:params.redirect)
		else
			render (view:'showGroup', model:[item: group])
	}

	def enableGroup = {
		def group = Group.findById(params.id)
		group.enabled = true
		group.locked = false
		if(params.redirect)
			redirect(action:params.redirect)
		else
			render (view:'showGroup', model:[item: group])
	}

	def disableGroup = {
		def group = Group.findById(params.id)
		group.enabled = false
		group.locked = false
		if(params.redirect)
			redirect(action:params.redirect)
		else
			render (view:'showGroup', model:[item: group])
	}
	
	def deleteGroup = { GroupCreateCommand groupCreateCmd ->
		def group = Group.findById(params.id)
		group.delete()
		redirect (action:'listGroups')
	}
	
	def listGroups = {
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "groupsCount"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listGroups(params.max, params.offset, params.sort, params.order);

		render (view:'listGroups', model:["groups" : results[0], "groupsTotal": Group.count(), "groupsCount": results[1], "menuitem" : "listGroups",
			appBaseUrl: request.getContextPath()])
	}
	
	def saveUser = {UserCreateCommand userCreateCmd->
		if(userCreateCmd.hasErrors()) {
			userCreateCmd.errors.allErrors.each { println it }
			render(view:'createUser', model:[item:userCreateCmd, roles: Role.list(),
						defaultRole: Role.findByAuthority("ROLE_USER")])
		} else {
			def user = userCreateCmd.createUser()
			if(user)  {
				if(!user.save()) {
					// Failure in saving
					user.errors.allErrors.each { println it }
					render(view:'createUser', model:[item:userCreateCmd, roles: Role.list(),
								msgError: 'The user has not been saved successfully'])
				} else {
					updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.ADMIN.value()), params.Administrator)
					updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.MANAGER.value()), params.Manager)
					updateUserRole(user, Role.findByAuthority(DefaultUsersRoles.USER.value()), params.User)
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
	
	def listGroupUsers = {
		def user = injectUserProfile()
		def group = Group.findById(params.id)

		if (!params.max) params.max = 10
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "username"
		if (!params.order) params.order = "asc"

		def users = usersUtilsService.listGroupUsers(group, params.max, params.offset, params.sort, params.order);

		render (view:'listGroupUsers', model:[group: group, "users" : users, "usersTotal": User.count(), "usersroles": UserRole.list(), "roles" : Role.list(), "menuitem" : "listUsers"])
	}
	
	def listSystemUsers = {
		def user = injectUserProfile();
		def system = SystemApi.findById(params.id);

		if (!params.max) params.max = 10
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "username"
		if (!params.order) params.order = "asc"
		
		def users = usersUtilsService.listSystemUsers(system, params.max, params.offset, params.sort, params.order);

		render (view:'listGroupUsers', model:[system: system, "users" : users, "usersTotal": User.count(), "usersroles": UserRole.list(), "roles" : Role.list(), "menuitem" : "listUsers"])
	}
	
	def searchGroup = {
		render (view:'searchGroup', model:["menuitem" : "searchGroups"]);
	}
	
	def performGroupSearch = {
		def user = injectUserProfile()

		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def groups = [];
		def groupsCount = [:]
		def groupsStatus = [:]
		Group.list().each { agroup ->
			groupsCount.put (agroup.id, UserGroup.findAllWhere(group: agroup).size())
			groupsStatus.put (agroup.id, GroupUtils.getStatusLabel(agroup))
		}

		// Search with no ordering
		def groupCriteria = Group.createCriteria();
		def r = [];

		if(params.name!=null && params.name.trim().length()>0 &&
		params.shortName!=null && params.shortName.trim().length()>0) {
			println 'case 1'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
				and {
					like('name', params.name)
					like('shortName', params.shortName)
				}
			}
		} else if(params.name!=null && params.name.trim().length()>0 &&
		(params.shortName==null || params.shortName.trim().length()==0)) {
			println 'case 2'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
				like('name', params.name)
			}
		} else if((params.name==null || params.name.trim().length()==0) &&
		params.shortName!=null &&  params.shortName.trim().length()>0) {
			println 'case 3'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
				like('shortName', params.shortName)
			}
		} else {
			println 'case 4'
			r = groupCriteria.list {
				maxResults(params.max?.toInteger())
				firstResult(params.offset?.toInteger())
				order(params.sort, params.order)
			}
		}
		groups = r.toList();
		//}


		def groupsResults = []
		groups.each { groupItem ->
			def groupResult = [id:groupItem.id, name:groupItem.name, shortName: groupItem.shortName,
						description: groupItem.description, status: GroupUtils.getStatusLabel(groupItem), dateCreated: groupItem.dateCreated]
			groupsResults << groupResult
		}

		def paginationResults = ['offset':params.offset+params.max, 'sort':params.sort, 'order':params.order]


		def results = [groups: groupsResults, pagination: paginationResults, groupsCount: groupsCount]
		render results as JSON
	}
	
	protected def updateUserRole(def user, def role, def value) {
		if(value=='on') {
			UserRole ur = UserRole.create(user, role)
			ur.save(flush:true)
		} else {
			def ur = UserRole.findByUserAndRole(user, role)
			if(ur!=null) {
				ur.delete(flush:true)
			}
		}
	}
	
	def getUserRoles(def user) {
		def userRoles = []
		def ur = UserRole.findAllByUser(user)
		println ur
		ur.each { userRoles.add(it.role)}
		return userRoles
	}

	def getUserGroups(def user) {
		def ur = []
		def userGroups = []
		ur = UserGroup.findAllByUser(user)
		ur.each { userGroups.add(it.group)}
		return ur
	}
	
	protected def listOfGroupRoles() {
		def roles = []
		roles.add(DefaultGroupRoles.ADMIN)
		roles.add(DefaultGroupRoles.MANAGER)
		roles.add(DefaultGroupRoles.USER)
		roles
	}

	protected def listOfUserGroupStatus() {
		def roles = []
		roles.add(DefaultGroupStatus.ACTIVE)
		roles.add(DefaultGroupStatus.DISABLED)
		roles.add(DefaultGroupStatus.DELETED)
		roles
	}
	
	def updateUserStatus(def user, def status) {
		println status
		if(status==UserStatus.CREATED_USER.value()) {
			user.enabled = false
			user.accountExpired = false
			user.accountLocked = false
		} else if(status==UserStatus.ACTIVE_USER.value()) {
			user.enabled = true
			user.accountExpired = false
			user.accountLocked = false
		} else if(status==UserStatus.DISABLED_USER.value()) {
			user.enabled = false
			user.accountExpired = false
			user.accountLocked = false
		} else if(status==UserStatus.LOCKED_USER.value()) {
			user.enabled = true
			user.accountExpired = false
			user.accountLocked = true
		}
	}
	
	def addUsersToSystem = {
		def system = SystemApi.findById(params.id)
		render (view:'addUsersToSystem', model:["menuitem" : "searchGroup", 'system': system,
			appBaseUrl: request.getContextPath()]);
	}
	
	def addUserToSystem = {
		def user = User.findById(params.user)
		def system = SystemApi.findById(params.system)
		
		system.users.add(user);			
		redirect(action:'showSystem', params: [id: params.system]);
	}
	
	def addUsersToGroup = {
		def group = Group.findById(params.id)
		render (view:'addUsersToGroup', model:["menuitem" : "searchGroup", 'group': group,
			appBaseUrl: request.getContextPath()]);
	}

	//def addUserToGroups = {
	def	enrollUserInGroups = {
		def user = User.findById(params.id)
		render (view:'enrollUserInGroups', model:["menuitem" : "searchGroup", 'user': user,
			appBaseUrl: request.getContextPath()]);
	}
	
	def enrollUserInGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.group)
		
		def ug = new UserGroup(user:user, group:group,
			status: UserStatusInGroup.findByValue(DefaultUserStatusInGroup.ACTIVE.value()));
		
		if(!ug.save(flush: true)) {
			ug.errors.allErrors.each { println it }
		} else {
			ug.roles = []
			ug.roles.add GroupRole.findByAuthority(DefaultGroupRoles.USER.value())
		}
			
		redirect(action:'showUser', params: [id: params.user]);
	}
	
	def manageGroupsOfUser = {
		def user = User.findById(params.id)
		
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listUserGroups(user, params.max, params.offset, params.sort, params.order);

		render (view:'manageGroupsOfUser', model:["usergroups" : results, "groupsTotal": Group.count(), "menuitem" : "listGroups", "user": user])
	}
	
	def manageUsersInGroup = {
		def group = Group.findById(params.id)
		
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listGroupUsers(group, params.max, params.offset, params.sort, params.order);

		render (view:'manageUsersInGroup', model:["groupusers" : results, "usersTotal": results.size(), "menuitem" : "listGroups", "group": group])
	}
	
	def manageUsersOfSystem = {
		def system = SystemApi.findById(params.id);
		
		if (!params.max) params.max = 15
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "name"
		if (!params.order) params.order = "asc"

		def results = usersUtilsService.listSystemUsers(system, params.max, params.offset, params.sort, params.order);
		
		render (view:'manageUsersOfSystem', model:["users" : results, "usersTotal": results.size(), "menuitem" : "listGroups", "system": system])
	}
	
	
	def editGroup = {
		def group = Group.findById(params.id)
		render (view:'editGroup', model:[item: group, action: "edit"])
	}

	def updateGroup = { GroupEditCommand groupEditCmd ->
		if(groupEditCmd.hasErrors()) {
			/* groupCreateCmd.errors.allErrors.each { println it } */
			render(view:'editGroup', model:[item:groupCreateCmd])
		} else {
			def group = Group.findById(params.id)
			group.name = groupEditCmd.name
			group.shortName = groupEditCmd.shortName
			group.description = groupEditCmd.description

			if(groupEditCmd.privacy.equals(DefaultGroupPrivacy.PRIVATE.value())) {
				group.privacy = GroupPrivacy.findByValue(DefaultGroupPrivacy.PRIVATE.value());
			} else if(groupEditCmd.privacy.equals(DefaultGroupPrivacy.RESTRICTED.value())) {
				group.privacy = GroupPrivacy.findByValue(DefaultGroupPrivacy.RESTRICTED.value());
			} else if(groupEditCmd.privacy.equals(DefaultGroupPrivacy.PUBLIC.value())) {
				group.privacy = GroupPrivacy.findByValue(DefaultGroupPrivacy.PUBLIC.value());
			}

			if(groupEditCmd.status.equals(DefaultGroupStatus.ACTIVE.value())) {
				group.enabled = true
				group.locked = false
			} else if(groupEditCmd.status.equals(DefaultGroupStatus.DISABLED.value())) {
				group.enabled = false
				group.locked = false
			} else if(groupEditCmd.status.equals(DefaultGroupStatus.LOCKED.value())) {
				group.enabled = true
				group.locked = true
			}

			render (view:'showGroup', model:[item: group,
				appBaseUrl: request.getContextPath()])
		}
	}
	
	def editUserRoleInGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.id)
		
		def ug = UserGroup.findByUserAndGroup(user, group)
	
		render (view:'editUserInGroup', model:[action: "edit", usergroup: ug, userRoles: GroupRole.list()])
	}
	
	def updateUserInGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.group)
		
		def ug = UserGroup.findByUserAndGroup(user, group)
		ug.roles = []
		
		updateUserInGroupRole(ug, GroupRole.findByAuthority(DefaultGroupRoles.ADMIN.value()), params.Admin)
		updateUserInGroupRole(ug, GroupRole.findByAuthority(DefaultGroupRoles.MANAGER.value()), params.Manager)
		updateUserInGroupRole(ug, GroupRole.findByAuthority(DefaultGroupRoles.CURATOR.value()), params.Curator)
		updateUserInGroupRole(ug, GroupRole.findByAuthority(DefaultGroupRoles.GUEST.value()), params.Guest)
		updateUserInGroupRole(ug, GroupRole.findByAuthority(DefaultGroupRoles.USER.value()), params.User)
		
		if(params.Admin!='on' && params.Manager!='on' && params.Curator!='on' && params.Guest!='on'
				 && params.User!='on') {
			 updateUserInGroupRole(ug, GroupRole.findByAuthority(DefaultGroupRoles.GUEST.value()), 'on')
		}
		
		if(params.redirect)
			redirect(action:params.redirect, params: [id: params.user])
		else
			render (view:'/shared/showUser', model:[item: user])
	}
	
	def updateUserInGroupRole(def userGroup, def role, def value) {
		if(value=='on') {
			userGroup.roles.add role
		}
	}
	
	def getUserRolesInGroup(def user) {
		// UserInGroupRole (multiple roles are allowed)
		def userRoles = []
		def ur = UserRole.findAllByUser(user)
		println ur
		ur.each { userRoles.add(it.role)}
		return userRoles
	}
	
	def lockUserInGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.id)
		def usergroup = UserGroup.findByUserAndGroup(user, group);
		if(usergroup!=null) {
			usergroup.status = UserStatusInGroup.findByValue(DefaultUserStatusInGroup.LOCKED.value())
		}
		if(params.redirect) {
			if (params.redirectId)redirect(action:params.redirect, params: [id: params.redirectId])
			else redirect(action:params.redirect, params: [id: params.user])
		} else
			render (view:'/shared/showUser', model:[item: user])
	}
	
	def unlockUserinGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.id)
		def usergroup = UserGroup.findByUserAndGroup(user, group);
		if(usergroup!=null) {
			usergroup.status = UserStatusInGroup.findByValue(DefaultUserStatusInGroup.ACTIVE.value())
		}
		if(params.redirect) {
			if (params.redirectId)redirect(action:params.redirect, params: [id: params.redirectId])
			else redirect(action:params.redirect, params: [id: params.user])
		} else
			render (view:'/shared/showUser', model:[item: user])
	}
	
	def enableUserInGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.id)
		def usergroup = UserGroup.findByUserAndGroup(user, group);
		if(usergroup!=null) {
			usergroup.status = UserStatusInGroup.findByValue(DefaultUserStatusInGroup.ACTIVE.value())
		}
		if(params.redirect) {
			if (params.redirectId)redirect(action:params.redirect, params: [id: params.redirectId])
			else redirect(action:params.redirect, params: [id: params.user])
		} else
			render (view:'/shared/showUser', model:[item: user])
	}
	
	def disableUserInGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.id)
		def usergroup = UserGroup.findByUserAndGroup(user, group);
		if(usergroup!=null) {
			usergroup.status = UserStatusInGroup.findByValue(DefaultUserStatusInGroup.SUSPENDED.value())
		}
		if(params.redirect) {
			if (params.redirectId)redirect(action:params.redirect, params: [id: params.redirectId])
			else redirect(action:params.redirect, params: [id: params.user])
		} else
			render (view:'/shared/showUser', model:[item: user])
	}
	
	def removeUserFromGroup = {
		def user = User.findById(params.user)
		def group = Group.findById(params.id)
		def usergroup = UserGroup.findByUserAndGroup(user, group);
		if(usergroup!=null) {
			usergroup.delete()
		}
		if(params.redirect) {
			if (params.redirectId)redirect(action:params.redirect, params: [id: params.redirectId])
			else redirect(action:params.redirect, params: [id: params.user])
		} else
			render (view:'/shared/showUser', model:[item: user])
	}
	
	def removeUserFromSystem = {
		def user = User.findById(params.user)
		def system = SystemApi.findById(params.id)
		
		system.users.remove(user)
		if(params.redirect)
			redirect(action:params.redirect, params: [id: params.system])
		else
			render (view:'showSystem', model:[item: system, id:params.id])
	}
	
	def removeAdministratorFromSystem = {
		def user = User.findById(params.user)
		def system = SystemApi.findById(params.id)
		def usersystem = UserSystemApi.findByUserAndSystem(user, system);
		if(usersystem!=null) {
			usersystem.delete()
		}
		if(params.redirect) {
			if (params.redirectId)redirect(action:params.redirect, params: [id: params.redirectId])
			else redirect(action:params.redirect, params: [id: params.user])
		} else
			render (view:'/shared/showSystem', model:[item: params.id])
	}
	
	def removeGroupFromSystem = {
		println 'removing....'
		def system = SystemApi.findById(params.system)
		def group = Group.findById(params.id)
		
		println 'before: ' + system.groups.size();
		system.groups.remove(group)
		println 'after: ' + system.groups.size();
		
		if(params.redirect)
			redirect(action:params.redirect, params: [id: params.system])
		else
			render (view:'showSystem', model:[item: system])
	}
}