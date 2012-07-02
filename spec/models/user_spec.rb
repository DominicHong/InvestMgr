require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name=> "Dominic", :email => "blue_dominic@hotmail.com" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  describe "Check Name" do	
  	it "should require a name" do
    	no_name_user = User.new(@attr.merge(:name => ""))
    	no_name_user.should_not be_valid
  	end
  	
  	it "should reject names that are too long" do
    	long_name = "a" * 51
    	long_name_user = User.new(@attr.merge(:name => long_name))
    	long_name_user.should_not be_valid
  	end
  end
  
  describe "Check Email" do
    it "should accept valid email addresses" do
    	addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    	addresses.each do |address|
      		valid_email_user = User.new(@attr.merge(:email => address))
      		valid_email_user.should be_valid
  		end
    end

  	it "should reject invalid email addresses" do
    	addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    	addresses.each do |address|
      		invalid_email_user = User.new(@attr.merge(:email => address))
      		invalid_email_user.should_not be_valid
  		end
    end
    
	it "should reject duplicate email addresses" do
    	# Put a user with given email address into the database.
    	User.create!(@attr)
    	user_with_duplicate_email = User.new(@attr)
    	user_with_duplicate_email.should_not be_valid
  	end
    it "should reject email addresses identical up to case" do
    	upcased_email = @attr[:email].upcase
    	User.create!(@attr.merge(:email => upcased_email))
    	user_with_duplicate_email = User.new(@attr)
    	user_with_duplicate_email.should_not be_valid
  	end
  end
  
  
  describe "portfolio associations" do

    before(:each) do
      @user = User.create(@attr)
      @p1 = FactoryGirl.create(:portfolio, :user => @user, :created_at => 1.day.ago)
      @p2 = FactoryGirl.create(:portfolio, :user => @user, :created_at => 1.hour.ago)
    end
	
    
    it "should have a portfolios attribute" do
      @user.should respond_to(:portfolios)
    end
    
 	it "should destroy associated portfolios" do
      @user.destroy
      [@p1, @p2].each do |portfolio|
        Portfolio.find_by_id(portfolio.id).should be_nil
      end
    end    
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

