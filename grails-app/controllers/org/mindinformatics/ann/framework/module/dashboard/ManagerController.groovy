package org.mindinformatics.ann.framework.module.dashboard

import org.mindinformatics.ann.framework.module.security.users.Role
import org.mindinformatics.ann.framework.module.security.users.User
import org.mindinformatics.ann.framework.module.security.users.UserRole

class ManagerController extends DashboardController{

	def index = {
		println 'redirect'
		redirect(action: 'dashboard', mapping: "/dashboard")
	}
	
	def dashboard = {
		def loggedUser = injectUserProfile()
		
		if(loggedUser!=null)
			render (view:'/manager/managerHome',model:[loggedUser: loggedUser]);
	}
	
	def listUsers = {
		def user = injectUserProfile()

		if (!params.max) params.max = 10
		if (!params.offset) params.offset = 0
		if (!params.sort) params.sort = "username"
		if (!params.order) params.order = "asc"

		def users = usersUtilsService.listUsers(user, params.max, params.offset, params.sort, params.order);

		render (view:'/dashboard/listUsers', model:[user: user, "users" : users, "usersTotal": User.count(), "usersroles": UserRole.list(), "roles" : Role.list(), "menuitem" : "listUsers"])
	}
}
