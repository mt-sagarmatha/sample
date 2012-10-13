require 'spec_helper'

	describe MicropostsController do
		render_views

		describe "access controll" do
			it "should deny access to create"
				post :create
				response.should redirect_to(signin_path)
			end

			it "shoul deny access to destroy" do  
				delete :destroy :id => 1
				response.should redirect_to(signin_path)
			end

		describe "Post create" do	
			before(:each) do 
				@user = test_sign_in(Factory)
			end

			describe "failure" do

				before(:each) do
					@att = {content:""}
				end

				it "should rerender homepage" do
					lambda do 
						post :create, :user 
					end.should_not change(Micropost, :count)
				end
				
				it "should rerender homepage" do
					lambda do 
						post :create, :user 
					end.should_not change(Micropost, :count)
				end


			end

		end


end