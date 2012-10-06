require 'spec_helper'

describe "Users" do
  describe "sign up" do
  	describe "failure" do 
		  it "should not make a new user" do
		  	lambda do
					visit signup_path
					fill_in "Name", with: ""
					fill_in "Email", with: ""
					fill_in "password", with: ""
					fill_in 'confirmation', with: ""
					click_button 
					response.should render_template('users/new')
					response.should have_selector('div#error_explanations')
				end.should_not change(User, :count)
		  end
		end
		
		describe "success" do 
		  it "should  make a new user" do
		  	lambda do
					visit signup_path
					fill_in "Name", with: "baz"
					fill_in "Email", with: "baz@gmail.com"
					fill_in "password", with: "password"
					fill_in 'confirmation', with: "password"
					click_button 
					response.should have_selector('div.flash.success', content:"welcome")
					response.should render_template('user/show')
				end.should_not change(User, :count).by(1)
		  end
		end
		
	
		
	describe " sign in" do
		describe "failure" do			
			it "shouldn not sign use in" do
				visit signin_path
				fill_in "email", with:""
				fill_in "password", with:""
				click_button
				response.should have_selector('div.flash.error', content: "Invalid" )
				response.should render_template('sessions/new')
			end
		end
		describe "success in signing in" do
			it"should sign a user in and out"do
				user = Factory(:user)
				visit signin_path
				fill_in "email", with: user.email
				fill_in "password", with: user.password
				click_button
				controller.should be_signed_in
				click_link "Sign out"	
				controller.should_not be_signed_in
			end
		end
		
	end	
		
  end
end
