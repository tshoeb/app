class PartiesController < ApplicationController
  def new
	@parties = Parties.new
	@title = "Create Party Event"
  end
  
  def show
	@Parties = Parties.find(params[:id])
	@title = @parties.name
  end
  
  def create
	@parties = Parties.new(params[:parties])
	if @parties.save
		flash[:success] = "Party Created"
		redirect_to @parties
	else
		@title = "Create Party Event"
		render 'new'
	end
end
