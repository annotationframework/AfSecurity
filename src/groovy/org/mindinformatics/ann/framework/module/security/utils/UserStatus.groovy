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
* @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
*/
enum UserStatus {
	CREATED_USER("Created"),
	ACTIVE_USER("Active"),
	LOCKED_USER("Locked"),
	DISABLED_USER("Disabled")

	UserStatus(String value) {
		this.value = value
	}
	
	boolean isStatusValid(String status) {
		return status.equals(CREATED_USER.value) ||
			status.equals(ACTIVE_USER.value) ||
			status.equals(LOCKED_USER.value) ||
			status.equals(DISABLED_USER.value);
	}

	private final String value
	public String value() { return value }
}