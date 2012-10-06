require 'spec_helper'

describe "LayoutLinks" do
	it "should have a home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end
	
	it "should have a contact page '/contact'" do
		get '/contact'
		response.should have_selector('title', content: "Contact")
	end
	
	it "should have a contact page '/about'" do
		get '/about'
		response.should have_selector('title', content: "About")
	end
	
	it "should have a sign up page '/signup'" do
		get '/signup'
		response.should have_selector('title', :content => "Sign up")
	end
	
	it "should have a sign in  page '/signin'" do
		get '/signin'
		response.should have_selector('title', content: "Sign in")
	end
	
	it "should have right links on the layout"do 
		visit root_path
		response.should have_selector('title', content: "Home")
		click_link "About"
		response.should have_selector('title', content: "About")
		click_link "contact"
		response.should have_selector('title', content: "Contact")
		click_link "Home"
		response.should have_selector('title', content: "Home")
		click_link "Sign Up now"
		response.should have_selector('title', content: "Sign up")
		response.should have_selector('a[href="/"]>img')
	end
	
	describe "when not signed in" do
		
		before(:each) do
			@user = Factory(:user)
			visit signin_path
			fill_in :email, with: @user.email
			fill_in :password, with: @user.password
		end
	
		it "should have a signin link" do
			visit root_path
			response.should have_selector("a", href: signin_path, content: "Sign in")	
		end
		it "should have signout link" do
			visit root_path
			response.should have_selector("a", href: signout_path, content: "Sign out")	
		end	
		
		it "should have profile link" do
			visit root_path
			response.should have_selector("a", href: user_path(@user), content: "Profile")	
		end		
	end
	
end
