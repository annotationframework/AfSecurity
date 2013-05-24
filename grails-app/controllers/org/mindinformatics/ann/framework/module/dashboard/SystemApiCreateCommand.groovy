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

import grails.validation.Validateable

import org.mindinformatics.ann.framework.module.security.systems.SystemApi


/**
 * Object command for Group validation and creation.
 * 
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
@Validateable
class SystemApiCreateCommand {
	
	public static final Integer NAME_MAX_SIZE = 255;
	public static final Integer SHORTNAME_MAX_SIZE = 16;
	public static final Integer DESCRIPION_MAX_SIZE = 1024;
	
	String name;
	String shortName;
	String description;

	boolean enabled;
	
	static constraints = {
		name (nullable:false, blank: false, maxSize:NAME_MAX_SIZE)
		shortName (nullable:false, blank: false, maxSize:SHORTNAME_MAX_SIZE)
		description (nullable:false, blank:true, maxSize:DESCRIPION_MAX_SIZE)
	}
	
	boolean isEnabled() {
		return enabled;
	}
	
	SystemApi createSystem() {
		// Names and nicknames are supposed to be unique
		println '-------createSystem'
		if(SystemApi.findByName(name)!=null || SystemApi.findByShortName(shortName)!=null) return null;

		// If the group does not exist I create a new one
		else {
			def key = UUID.randomUUID() as String
			SystemApi sys = new SystemApi(name:name, shortName:shortName, description:description, 
			enabled: true, apikey: key);
		}
	}
}
