# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  before(:each) do
  	@att = {name: "emin", email: "emain@gamil.com"}

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
  
end
