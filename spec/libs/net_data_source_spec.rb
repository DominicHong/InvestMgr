#coding: UTF-8
require 'spec_helper'
Dir["#{Rails.root.to_s}/lib/*.rb"].each { |rb| require rb }
Dir["#{Rails.root.to_s}/vendor/*.rb"].each { |rb| require rb }

describe NetDataSource do

  before(:each) do
    @stock = Stock.first
  end

  it "gets a live quote from internet and save it" do
   nds = NetDataSource.new
   @quote = nds.getQuote(@stock)
   @quote.should be_valid
   @quote.security.should == @stock
 end

 it "gets a correct historical quote from Yahoo API and save it" do
   YahooFinance::get_HistoricalQuotes( "600036.ss", 
   Date.parse( "2011-06-17" ),
   Date.parse("2011-06-17") ) {|hq|
     quote = Quote.new
     quote.sid = "600036"
     quote.market = "sh"
     quote.name = "cmb"
     quote.result_date = hq.date
     quote.open = hq.open
     quote.high = hq.high
     quote.low = hq.low
     quote.close = hq.close
     quote.adjClose = hq.adjClose
     quote.vol = hq.volume
     quote.security = Stock.where(:market => "sh", :sid => "600036").first
     quote.save!

     quote.open.should == 12.74
     quote.high.should == 12.89
     quote.low.should == 12.70
     quote.close.should == 12.78
     quote.adjClose.should == 12.78
     quote.vol.should == 27880300
   }  	
 end 
end
