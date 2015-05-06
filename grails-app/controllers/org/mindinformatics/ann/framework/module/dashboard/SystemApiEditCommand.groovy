package org.mindinformatics.ann.framework.module.dashboard

import grails.validation.Validateable
import org.mindinformatics.ann.framework.module.security.systems.SystemApi
import org.mindinformatics.ann.framework.module.security.users.User;

/**
 * Object command for Group validation and creation.
 *
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
@Validateable
class SystemApiEditCommand extends SystemApiCreateCommand {
	
	String id;

    public static final Integer NAME_MAX_SIZE = 255;
    public static final Integer SHORTNAME_MAX_SIZE = 16;
    public static final Integer DESCRIPION_MAX_SIZE = 1024;

    String name;
    String shortName;
    String description;
    String apikey;
    String secretKey

    User createdBy;

    boolean enabled;

    static constraints = {
        id (nullable:false, blank: false)
        name (nullable:false, blank: false, maxSize:NAME_MAX_SIZE)
        shortName (nullable:false, blank: false, maxSize:SHORTNAME_MAX_SIZE)
        description (nullable:false, blank:true, maxSize:DESCRIPION_MAX_SIZE)
        apikey (nullable:false, blank: false, unique: true, maxSize:255)
        secretKey (nullable:true, maxSize: 255)
    }

    boolean isEnabled() {
        return enabled;
    }

    SystemApi createSystem() {
        // Names and nicknames are supposed to be unique
        println '-------createSystem'
        if(SystemApi.findByName(name)!=null || SystemApi.findByShortName(shortName)!=null)
            return null;

        // If the group does not exist I create a new one
        else {
            def key = UUID.randomUUID() as String
            def secretKey = UUID.randomUUID() as String
            SystemApi sys = new SystemApi(
                    name:name, shortName:shortName, description:description,
                    enabled:true, apikey:key, secretKey: secretKey);
        }
    }

}