package org.mindinformatics.ann.framework.module.dashboard

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
}
