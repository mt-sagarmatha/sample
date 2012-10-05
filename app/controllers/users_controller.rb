class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@title = User.name
  end
  
  def new
  	@user = User.new
  	@title = "Sign up"
  end
  
  def create
  	#raise params[:user].inspect
  	@user = User.new(params[:user])
  	if @user.save
  		flash[:success] = "welcome to the sample app!"
  		redirect_to @user #or redirect_to @user
  	else
  		@title = "Sign up"
  		render 'new'
		end
  end
  
end
