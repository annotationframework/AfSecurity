package org.mindinformatics.ann.framework.module.dashboard

import grails.validation.Validateable;

/**
 * Object command for Group validation and creation.
 *
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
@Validateable
class SystemApiEditCommand extends SystemApiCreateCommand {
	
	String id;
	
	static constraints = {
		id (nullable:false, blank: false)
	}
}