class HostsController < ApplicationController
  def new
	@host = Host.new
	@title = "Sign up"
  end
  
  def index
	@hosts = Host.all
  end
  
  def show
	@host = Host.find(params[:id])
	@title = @host.name
  end
  
  def create
	@host = Host.new(params[:host])
	if @host.save
		sign_in @user
		flash[:success] = "Welcome to Party Manager"
		redirect_to @host
	else
		@title = "Sign Up"
		render 'new'
	end
  end
end
