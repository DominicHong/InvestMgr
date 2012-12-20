# == Schema Information
#
# Table name: quotes
#
#  id          :integer(4)      not null, primary key
#  sid         :string(255)
#  market      :string(255)
#  name        :string(255)
#  open        :decimal(8, 3)
#  close       :decimal(8, 3)
#  adjClose    :decimal(8, 3)
#  current     :decimal(8, 3)
#  high        :decimal(8, 3)
#  low         :decimal(8, 3)
#  bid         :decimal(8, 3)
#  ask         :decimal(8, 3)
#  vol         :integer(13)
#  amount      :integer(15)
#  result_date :datetime
#  security_id :integer(4)
#

require 'spec_helper'

describe Quote do

  before(:each) do
   @quote = Quote.new(
   :sid => "600036",
   :market => "sh",
   :name => "cmb",
   :open => 12.74,
   :high => 12.89,
   :low => 12.70,
   :close => 12.78,
   :adjClose => 12.78,
   :vol => 27880300,
   :result_date => Date.parse( "2011-06-17" ),
   :security => Security.first)
 end

 it "is valid with valid attributes" do
   @quote.should be_valid	
 end
 it "is not valid without a security" do
   @quote.security_id = nil
   @quote.should_not be_valid
 end

 it "is not valid with LOW greater than HIGH" do
   @quote.low = 13
   @quote.should_not be_valid
 end
 it "is not valid without a sid" do
   @quote.sid = nil
   @quote.should_not be_valid
 end
 it "is not valid without a name" do
   @quote.name = nil
   @quote.should_not be_valid
 end
 it "is not valid without a market" do
   @quote.market = nil
   @quote.should_not be_valid
 end
 it "is not valid if OPEN < 0" do
   @quote.open = -1
   @quote.should_not be_valid
 end
 it "is not valid if CLOSE < 0" do
   @quote.close = -1
   @quote.should_not be_valid
 end
 it "is not valid if LOW < 0" do
   @quote.low = -1
   @quote.should_not be_valid
 end
 it "is not valid if VOL < 0" do
   @quote.vol = -1
   @quote.should_not be_valid
 end

 it "CNOOC quote have correct close price in RMB" do
    FactoryGirl.create(:quote).closeInRMB.should == 12.8
 end
end
