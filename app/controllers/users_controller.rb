class UsersController < ApplicationController 
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

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
  		sign_in @user
  		flash[:success] = "welcome to the sample app!"
  		redirect_to @user #or redirect_to @user
  	else
  		@title = "Sign up"
  		render 'new'
		end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit User"
  end

  def update
    @user = User.find(params[:id]) 
    
    if @user.update_attributes(params[:user])
        redirect_to @user, flash: {success:"profile updated!"}
    else
      @title = "edit user"
      render 'edit'   
    end     
  end

private
  def authenticate
       deny_access unless signed_in? 
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
    
  end
 
  
end
