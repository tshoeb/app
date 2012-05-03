class SessionsController < ApplicationController
  def new
	@title = "Sign in"
  end
  
  def create
	host = Host.authenticate(params[:session][:email], params[:session][:password])
	
	if user.nil?
		flash.now[:error] = "Invalied email/password combination."
		@title = "Sign in"
		render 'new'
	else
		sign_in host
		redirect_to host
	end
  end
  
  def destroy
	sign_out
	redirect_to root_path
  end
  
end
