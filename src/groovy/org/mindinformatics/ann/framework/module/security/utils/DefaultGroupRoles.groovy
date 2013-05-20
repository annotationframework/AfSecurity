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
package org.mindinformatics.ann.framework.module.security.utils

/**
 * These are the default entries for group roles. The entries are supposed 
 * to be sat up in the Bootstrap.groovy file as follows:
 * 
 * log.info  '** Groups Roles'
 * DefaultGroupRoles.values().each {
 *      if(!GroupRole.findByAuthority(it.value())) {
 *           new GroupRole(authority: it.value(), ranking: it.ranking(), label: it.label(), description: it.description()).save(failOnError: true)
 *           log.info "Initialized: " + it.value()
 *		}
 * }
 * 
 * Alternative group roles can be defined with a similar approach.
 * 
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
enum DefaultGroupRoles {
	ADMIN("GROUP_ADMIN", 10000, "Admin", "Administrator can set up an instance of the platform and create other administrators or managers."), 
	MANAGER("GROUP_MANAGER", 1000, "Manager", "Managers are allowed to create groups and assign their management to specific users that will cover specific roles in that context."), 
	CURATOR("GROUP_CURATOR", 100, "Curator", "Curators are allowed to moderate the annotation content that has been made public for the group."),
	USER("GROUP_USER", 10, "User", "Users can request to managers the creation of groups "),
	GUEST("GROUP_GUEST", 1, "Guest", "Guests can see the annotation but they cannot create new annotation nore modify the existing one")
	
	DefaultGroupRoles(String value, int ranking, String label, String description) {
		this.value = value;
		this.ranking = ranking;
		this.label = label;
		this.description = description;
	}
	
	private final String value
	public String value() { return value }
	private final int ranking
	public String ranking() { return ranking }
	private final String label
	public String label() { return label }
	private final String description
	public String description() { return description }
}
