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
		response.should have_selector('title', :content => "About")
	end
	
end