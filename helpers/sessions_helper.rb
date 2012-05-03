module SessionsHelper

	def sign_in(host)
		cookies.permanent.signed[:remember_token] = [host.id, host.salt]
		self.current_user = user
	end
	
	def current_host=(host)
		@current_host = host
	end
	
	def current_host
		@current_host ||= host_from_remember_token
	end
	
	def signed_in?
		!current_host.nil?
	end
	
	def sign_out
		cookies.delete(:remember_token)
		self.current_host = nil
	end
	
	private
	
	def host_from_remember_token
		Host.authenticate_with_salt(*remember_token)
	end
	
	def remember_token
		cookies.signed[:remember_token] || [nil, nil]
	end
	
end
