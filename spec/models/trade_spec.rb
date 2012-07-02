require 'spec_helper'

describe Trade do
	before(:each) do
   @portfolio = FactoryGirl.create(:portfolio)
   @stock = FactoryGirl.create(:stock)		
   @attr = { :state => 1, 
     :buy => true,
     :trade_date => DateTime.parse("2011-07-25"),
     :clear_date => DateTime.parse("2011-07-25"),
     :vol => 100.00,
     :price => 20.00,
     :amount => 100*20,
     :fee => 1.5,
     :security_id => @stock.id
   }
 end

 it "should create a new instance given valid attributes" do
  @portfolio.trades.create!(@attr)
end

describe "sell_type" do
  it "should allow 'AVG' sell_type" do
   @portfolio.trades.create!(@attr.merge(:sell_type => "AVG"))
 end
 it "should allow 'FIFO' sell_type" do
   @portfolio.trades.create!(@attr.merge(:sell_type => "FIFO"))
 end
 it "should allow 'LIFO' sell_type" do
   @portfolio.trades.create!(@attr.merge(:sell_type => "LIFO"))
 end
 it "should allow 'SPECIFIC' sell_type" do
   @portfolio.trades.create!(@attr.merge(:sell_type => "SPECIFIC"))
 end
 it "should allow nil sell_type" do
   @portfolio.trades.create!(@attr.merge(:sell_type => nil))
 end
 it "should NOT allow sell_types other than 'AVG' 'FIFO' 'LIFO' 'SPECIFIC' or nil " do
   @portfolio.trades.build(@attr.merge(:sell_type => "aaa")).should_not be_valid
 end
end

describe "portfolio associations" do
  before(:each) do
   @trade = @portfolio.trades.create(@attr)
 end
 it "should have a portfolio attribute" do
   @trade.should respond_to(:portfolio)
 end
 it "should have the right associated portfolio" do
   @trade.portfolio_id.should == @portfolio.id
   @trade.portfolio.should == @portfolio
 end
end

describe "security association" do
  before(:each) do
   @trade = @portfolio.trades.create(@attr)
 end
 it "should have a security attribute" do
   @trade.should respond_to(:security)
 end
 it "should have the right associated security" do
   @trade.security_id.should == @stock.id
   @trade.security.should == @stock
 end
end

describe "validations" do
  before(:each) do
   @trade = @portfolio.trades.create(@attr)
 end

 it "is valid with valid attributes" do
   @trade.should be_valid 
 end
 it "should require a portfolio id" do
   @trade.portfolio_id = nil
   @trade.should_not be_valid
 end
 it "should require a security id" do
   @trade.security_id = nil
   @trade.should_not be_valid
 end

 it "should belong to a portfolio that exists" do
   @trade.portfolio_id = 999999999999
   @trade.should_not be_valid
 end

 it "should belong to a security that exists" do
   @trade.security_id = 999999999999
   @trade.should_not be_valid
 end

 it "should require a trade_date" do
   @trade.trade_date = nil
   @trade.should_not be_valid
 end

 it "should have a trade_date no later than clear_date" do
   early_date = DateTime.parse("2011-7-29")
   late_date = DateTime.parse("2011-7-30")
   @trade.trade_date = late_date
   @trade.clear_date = early_date
   @trade.should_not be_valid
 end
 it "is not valid if VOL <= 0" do
   @trade.vol = 0
   @trade.should_not be_valid
 end

end
end



# == Schema Information
#
# Table name: trades
#
#  id           :integer(4)      not null, primary key
#  portfolio_id :integer(4)
#  state        :integer(4)
#  buy          :boolean(1)
#  sell_type    :string(255)
#  trade_date   :datetime
#  clear_date   :datetime
#  vol          :decimal(10, 3)
#  price        :decimal(8, 3)
#  amount       :decimal(12, 3)
#  fee          :decimal(8, 3)
#  security_id  :integer(4)
#

