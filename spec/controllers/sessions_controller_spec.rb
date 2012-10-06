require 'spec_helper'

describe SessionsController do
	render_views
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  
		it "should have the right tite" do
			get :new 
			response.should have_selector('title', content: 'Sign in')
		end
	end
	
	
	
	describe " Post 'create'" do
		describe "failure" do
			before(:each) do
				@att = {email:"", password:""}
			end
	
			it "should render new page" do
				post :create, :session =>@att
				response.should render_template('new')
			end
			
			it "should have error message" do
				post :create, session: @att
				flash.now[:error].should =~ /invalid/i
			end	
		end
		
		describe "sucessful sign in" do
			before(:each) do
				@user = Factory(:user)
				@att = {email: @user.email, password: @user.password}
			end	
	
			it "should redirect to user" do
				post :create, session: @att
				response.should redirect_to(user_path(@user))
			end
		
		
		end
	end
end

