package org.mindinformatics.ann.framework.module.security

class UserAccountRequestService {

	def moderateAccountRequests(def user, def max, def offset, def sort, def _order) {
		//AccountRequest.list();
		
		def accountRequestCriteria = UserAccountRequest.createCriteria();
		def r = accountRequestCriteria.list {
			maxResults(max?.toInteger())
			firstResult(offset?.toInteger())
			order(sort, _order)
			eq('moderated', false )
			
		}
		r.toList();
	}
	
	def pastAccountRequests(def user, def max, def offset, def sort, def _order) {
		//AccountRequest.list();
		
		def accountRequestCriteria = UserAccountRequest.createCriteria();
		def r = accountRequestCriteria.list {
			maxResults(max?.toInteger())
			firstResult(offset?.toInteger())
			order(sort, _order)
			eq('moderated', true )
			
		}
		r.toList();
	}
}
