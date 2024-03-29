require 'spec_helper'

describe UsersController do
	render_views
  
  describe "Get index" do
    describe "non signed in users" do
      it "should deny access "do
        get :index
        response.should redirect_to(signin_path)
      end 
    end
   
    describe " signed in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        Factory(:user,:email =>"another@example.com")
        Factory(:user,:email =>"another@example.net")

        30.times do
          Factory(:user, email: Factory.next(:email))
        end

      end

      it "should be success "do
        get :index
        response.should be_success
      end

      it "should have an element for each user" do
        get :index
        User.paginate(:page =>1) each do |user|
          response.should have_selector('li', content: user.name)
        end
      end

      it "shoud paginate" do
        get :index
        response.should have_selector('div.pagination')
        response.should have_selector('span.disabled', content: "previous")
        response.should have_selector('a', href: '/users?page=2', content: '2')
      end

    end


  end
  
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
