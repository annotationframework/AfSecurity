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
 * These are the default entries for group privacy. The entries are supposed 
 * to be sat up in the Bootstrap.groovy file as follows:
 * 
 * log.info  '** Groups Privacy'
 * DefaultGroupPrivacy.values().each {
 *      if(!GroupPrivacy.findByValue(it.value())) {
 *           new GroupPrivacy(value: it.value(), uuid: it.uuid(), label: it.label(), description: it.description()).save(failOnError: true)
 *			 log.info  createdPrefix() + it.value()
 *      }
 * }
 * 
 * Alternative Privacy levels can be defined with a similar approach.
 * 
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
enum DefaultGroupPrivacy {

	PRIVATE("GROUP_PRIVATE", "Private", "Private", "org.mindinformatics.domeo.uris.visibility.Private"),
	RESTRICTED("GROUP_RESTRICTED", "Restricted", "Restricted", "org.mindinformatics.domeo.uris.visibility.Restricted"),
	PUBLIC("GROUP_PUBLIC", "Public", "Public", "org.mindinformatics.domeo.uris.visibility.Public")
	
	DefaultGroupPrivacy(String value, String label, String description, String uuid) {
		this.value = value
		this.label = label;
		this.description = description;
		this.uuid = uuid;
	}

	private final String uuid
	public String uuid() { return uuid }
	private final String value
	public String value() { return value }
	private final String label
	public String label() { return label }
	private final String description
	public String description() { return description }
}
