# == Schema Information
#
# Table name: securities
#
#  id       :integer(4)      not null, primary key
#  sid      :string(255)
#  market   :string(255)
#  name     :string(255)
#  nav      :integer(4)
#  capacity :integer(4)
#  type     :string(255)
#

require 'spec_helper'

describe Security do

  before(:each) do
   @Security = Stock.new(
   :sid => "600036",
   :market => "sh",
   :name => "cmb"
   )
 end

 it "is valid with valid attributes" do
   @Security.should be_valid	
 end

 it "should be a Stock" do
   @Security.class.should == Stock
 end

end

# == Schema Information
#
# Table name: securities
#
#  id       :integer(4)      not null, primary key
#  sid      :string(255)
#  market   :string(255)
#  name     :string(255)
#  nav      :integer(4)
#  capacity :integer(4)
#  type     :string(255)
#
