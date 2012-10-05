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
		
		
		
		
  end
end
