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
import org.mindinformatics.ann.framework.module.security.groups.UserGroup
import org.mindinformatics.ann.framework.module.security.users.Role
import org.mindinformatics.ann.framework.module.security.users.User
import org.mindinformatics.ann.framework.module.security.users.UserRole
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupPrivacy
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupRoles
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupStatus
import org.mindinformatics.ann.framework.module.security.utils.DefaultUsersRoles
import org.mindinformatics.ann.framework.module.security.utils.UserStatus
import org.mindinformatics.ann.framework.module.security.utils.UserUtils


/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
public class DashboardController {

	def springSecurityService
	def usersUtilsService
	
	protected def injectUserProfile() {
		def principal = springSecurityService.principal
		if(principal.equals("anonymousUser")) {
			redirect(controller: "login", action: "index");
		} else {
			String username = principal.username
			def user = User.findByUsername(username);
			if(user==null) {
				log.error "Error:User not found for username: " + username
				render (view:'error', model:[message: "User not found for username: "+username]);
			}
			user
		}
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
						isUser: roles.role.authority.contains(DefaultUsersRoles.USER.value()),
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
				render (view:'showUser', model:[user: user,
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
	
	def showGroup = {
		def group = Group.findById(params.id)
		render (view:'showGroup', model:[item: group,
			appBaseUrl: request.getContextPath()])
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
	
	def searchGroup = {
		render (view:'searchGroup', model:["menuitem" : "searchGroup"]);
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
			groupsStatus.put (agroup.id, agroup.status)
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
						description: groupItem.description, status: groupItem.statusLabel, dateCreated: groupItem.dateCreated]
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
}