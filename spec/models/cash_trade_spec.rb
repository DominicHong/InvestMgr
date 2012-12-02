require 'spec_helper'

describe CashTrade do
	let(:portfolio) { FactoryGirl.create(:portfolio) }
	let(:stock) { FactoryGirl.create(:stock) }
	let(:cash_trade) { FactoryGirl.create(:cash_trade) }
	let(:trade) { FactoryGirl.create(:trade) }
	subject { cash_trade }
  it "should create a CashTrade even if a security_id hasn't been set" do
    portfolio.cash_trades.create!(
      :buy => false,
      :trade_date => DateTime.parse("2012-07-19"),
      :amount => 100)
  end
  
  it "should return Cash as Security even if security is set otherwise" do
  	cash_trade.security = Stock.first
  	cash_trade.security.should == Cash.first
  end
  it "should return correct cf() for general Trades and CashTrades" do
  	cash_trade.cf.should == 100
  	cash_trade.cf.should == cash_trade.amount
  	trade.cf.should == -(trade.amount + trade.fee)
	trade.cf.should == -2001.5
  end

end
