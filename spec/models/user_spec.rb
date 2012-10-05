# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#

require 'spec_helper'

describe User do
  
  before(:each) do
  	@att = {
  		name: "Emin",
  		email: "emain@gamil.com",
  		password: "foofoobar",
  		password_confirmation: "foofoobar"
  	}

  end
  
  
  it "should create new instance" do
  	User.create!(@att)
  end
  
  it "shoudl require a name" do
  	no_name_user = User.new(@att.merge(name:""))
  	no_name_user.should_not be_valid
  end
  
  it "shoudl require a email" do
  	no_email_user = User.new(@att.merge(email:""))
  	no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
  	long_name = "a" * 51
  	long_name_user = User.new(@att.merge(name: long_name))
  	long_name_user.should_not be_valid
  end
  
  it "should accept valid emails" do
		address = %w[user@foo.com THigEjb@dasd.org my@org.jp]
		address.each do |addr|
			valid_email = User.new(@att.merge(email: addr))
			valid_email.should be_valid
		end
  end
  
  it "should reject invalid emails" do
		address = %w[user@foo,com THE@das%d.org my_org.jp]
		address.each do |addr|
			invalid_email = User.new(@att.merge(email: addr))
			invalid_email.should_not be_valid
		end
  end
  
  it "should reject duplicate email" do
		User.create!(@att)
		duplicate = User.new(@att)
		duplicate.should_not be_valid
  end
  
  it "should reject duplicate email up to case" do
		upcased_email = @att[:email].upcase
		User.create!(@att.merge(email: upcased_email))
		duplicate = User.new(@att)
		duplicate.should_not be_valid
  end
  
  describe "passwords" do
		
		before(:each) do 
			@user = User.new(@att)
		end
		
		it "should have a password" do 
			@user.should respond_to(:password)
  	end
  	
  	it "should respond to password confirmation" do 
			@user.should respond_to(:password_confirmation)
  	end

  end
  
  describe "password validations" do
		it "should require a password" do
			User.new(@att.merge(password: "", password_confirmation: ""))
			should_not be_valid
		end
		
		it "should require a matching password" do
			User.new(@att.merge(password_confirmation: "invalid"))
			should_not be_valid
		end
		
		it "should reject shor password" do
			short = "a" * 5
			hash = @att.merge(password: short, password_confirmation: short)
			User.new(hash).should_not be_valid
		end	
  end
  
  describe "password encryption" do
  	before(:each) do
  		@user = User.create!(@att)
  	end
  	
  	it "should be encrypted " do
  		@user.should respond_to(:encrypted_password)
  	end	
  	
  	it "should have salt " do
  		@user.should respond_to(:salt)
  	end	
  	
  	it "should not be blank" do
  		@user.encrypted_password.should_not be_blank
  	end
  	
  	describe "has password? method" do
  	
			it "should exist" do
				@user.should respond_to(:has_password?)
	 		end
	 		
	 		it "should return true if passwords match" do
				@user.has_password?(@att[:password]).should be_true
	 		end
  	end
  	
  	describe "authenticate method" do
			it "should return nil on email/pass missmatch" do
				User.authenticate(@att[:email], "wrong").should be_nil
			end
			
			it "should return nil for email with no user" do
				User.authenticate("bullshit@foo.com", @att[:password]).should be_nil
			end
			
			it "should return user on match" do
				User.authenticate(@att[:email], @att[:password]).should == @user
			end
		end
  end
  
end
