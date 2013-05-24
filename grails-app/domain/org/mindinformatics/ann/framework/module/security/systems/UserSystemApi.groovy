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
package org.mindinformatics.ann.framework.module.security.systems;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.mindinformatics.ann.framework.module.security.circles.Circle;
import org.mindinformatics.ann.framework.module.security.circles.UserCircle;
import org.mindinformatics.ann.framework.module.security.users.User;

/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
public class UserSystemApi implements Serializable {

	Date dateCreated, lastUpdated // Grails automatic timestamping
	
	User user
	SystemApi system
	
	static hasMany = [users: User, systems: SystemApi]
		
	boolean equals(other) {
		if (!(other instanceof UserSystemApi)) {
			return false
		}

		other.user?.id == user?.id &&
			other.system?.id == system?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (user) builder.append(user.id)
		if (system) builder.append(system.id)
		builder.toHashCode()
	}

	static UserSystemApi get(long userId, long systemId) {
		find 'from UserSystemApi where user.id=:userId and system.id=:systemId',
			[userId: userId, groupId: systemId]
	}
	
	static def getByUserId(long userId) {
		findAll 'from UserSystemApi where user.id=:userId',
			[userId: userId]
	}

	static UserSystemApi create(User user, SystemApi system, boolean flush = false) {
		new UserSystemApi(user: user, system: system).save(flush: flush, insert: true)
	}

	static boolean remove(User user, SystemApi system, boolean flush = false) {
		UserSystemApi instance = UserSystemApi.findByUserAndSystemApi(user, system)
		instance ? instance.delete(flush: flush) : false
	}

	static void removeAll(User user) {
		executeUpdate 'DELETE FROM UserSystemApi WHERE user=:user', [user: user]
	}

	static void removeAll(SystemApi system) {
		executeUpdate 'DELETE FROM UserSystemApi WHERE system=:system', [system: system]
	}

	static mapping = {
		id composite: ['system', 'user']
		version false
	}
}


