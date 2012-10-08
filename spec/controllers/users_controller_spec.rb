require 'spec_helper'

describe UsersController do
	render_views
  
  
  describe "GET 'show'" do
  
  	before(:each) do
  		@user = Factory(:user)
  	end
  	
    it "returns http success" do
      get 'show', id: @user.id
      response.should be_success
    end
    
    it "should get right user" do
      get 'show', id: @user.id
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get 'show', id: @user.name
      response.should have_selector('title', content: @user.name)
    end
    
    it "should have the right title" do
      get 'show', id: @user
      response.should have_selector('h1', content: @user.name)
    end
    
    it "should have image" do
      get 'show', id: @user
			response.should have_selector('h1>img', class: "gravatar")
    end
    
    it "should have the right url" do
      get 'show', id: @user
			response.should have_selector('td>a', content: user_path(@user), href: user_path(@user))
    end
    
  end


  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
  	it "should have right title" do
  		get 'new'
  		response.should have_selector('title', :content => "Sign up")
  	end    
  end
  
  describe "Post Create" do
		describe "failure" do
			before(:each) do 
				@att = {name:"", email:"", password: "", password_confirmation:""}
			end
			
			it "should not create a user" do
				lambda do
					post :create, user: @att
				end.should_not change(User, :count )
			end
			
			it "should have right title" do
				post :create, user: @att
				response.should have_selector('title', content: "Sign up")
			end
			
			it "should rend new page" do
				post :create, :user => @att
				response.should render_template('new')
			end
		end
		
		describe "success" do
			
			before(:each) do 
				@att = {name:"new user", email:"new@example.com", password: "foofoobar", password_confirmation:"foofoobar"}
			end
			
			it "should create a user" do
				lambda do
					post :create, user: @att
				end.should change(User, :count).by(1)
			end
		
			it "should redirect to user show page" do
				post :create, user: @att
				response.should redirect_to(user_path(assigns[:user]))
			end
			
			it "should redirect to user show page" do
				post :create, user: @att
				flash[:success].should =~ /welcome to the sample app!/i
			end
			
			it "should sign user in" do
				post :create, user: @att
				controller.should be_signed_in
			end
		end
  end

  describe "get edit " do 

  	before(:each) do
  		@user = Factory(:user)
  		test_sign_in(@user)
  	end

  	it "should be succesful" do
  		get :edit, :id => @user
  		response.should be_success
  	end

  	it "should have link to gravatar" do
  		get :edit, id: @user
  		response.should have_selector('a', href: 'http://gravatar.com/emails', content: 'change')
  	end
  end
  


end
