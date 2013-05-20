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
 * These are the default entries for users roles. The entries are supposed 
 * to be sat up in the Bootstrap.groovy file as follows:
 * 
 * log.info  '** Users roles'
 * DefaultUsersRoles.values().each {
 *      if(!Role.findByAuthority(it.value())) {
 *           new Role(authority: it.value(), ranking: it.ranking(), label: it.label(), description: it.description()).save(failOnError: true)
 *           log.info "Initialized: " + it.value()
 *      }
 * }
 * 
 * Alternative users roles can be defined with a similar approach.
 * 
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
enum DefaultUsersRoles {
	ADMIN(10000, 
		"ROLE_ADMIN", 
		"Administrator", 
		"Administrator can set up an instance of the platform and appoint other administrators or managers."), 
	MANAGER(10, 
		"ROLE_MANAGER",
		"Manager", 
		"Managers are allowed to create new groups and managing existing ones that have been created by others."), 
	USER(1, 
		"ROLE_USER", 
		"User", 
		"Users are allowed to create new groups and manage them.");
	
	DefaultUsersRoles(int ranking, String value, String label, String description) { 
		this.value = value; 
		this.label = label;	
		this.ranking = ranking;
		this.description = description;
	}
	
	private int ranking
	private String value
	private String label
	private String description
	
	public String value() { return value }
	public int ranking() { return ranking }
	public String label() { return label }
	public String description() { return description }
}
