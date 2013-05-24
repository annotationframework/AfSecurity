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
package org.mindinformatics.ann.framework.module.security.groups

import org.apache.commons.lang.builder.HashCodeBuilder
import org.mindinformatics.ann.framework.module.security.users.User
import org.mindinformatics.ann.framework.module.security.utils.DefaultGroupRoles;

/**
* @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
*/
class UserGroup implements Serializable {

	User user
	Group group
	UserStatusInGroup status
	
	Date dateCreated, lastUpdated // Grails automatic timestamping
	
	static hasMany = [roles: GroupRole]
	
	boolean isGuest() {
		def course = roles.find { it.authority == DefaultGroupRoles.GUEST.value() }
		if(roles.size()==1 && course!=null) return true;
		return false;
	}
	
	boolean equals(other) {
		if (!(other instanceof UserGroup)) {
			return false
		}

		other.user?.id == user?.id &&
			other.group?.id == group?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (user) builder.append(user.id)
		if (group) builder.append(group.id)
		builder.toHashCode()
	}

	static UserGroup get(long userId, long groupId) {
		find 'from UserGroup where user.id=:userId and group.id=:groupId',
			[userId: userId, groupId: groupId]
	}
	
	static def getByUserId(long userId) {
		findAll 'from UserGroup where user.id=:userId',
			[userId: userId]
	}

	static UserGroup create(User user, Group group, boolean flush = false) {
		new UserGroup(user: user, group: group).save(flush: flush, insert: true)
	}

	static boolean remove(User user, Group group, boolean flush = false) {
		UserGroup instance = UserGroup.findByUserAndGroup(user, group)
		instance ? instance.delete(flush: flush) : false
	}

	static void removeAll(User user) {
		executeUpdate 'DELETE FROM UserGroup WHERE user=:user', [user: user]
	}

	static void removeAll(Group group) {
		executeUpdate 'DELETE FROM UserGroup WHERE group=:group', [group: group]
	}

	static mapping = {
		id composite: ['group', 'user']
		version false
	}
}
