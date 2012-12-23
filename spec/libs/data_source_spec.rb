#coding: UTF-8
require 'spec_helper'
Dir["#{Rails.root.to_s}/lib/*.rb"].each { |rb| require rb }
Dir["#{Rails.root.to_s}/vendor/*.rb"].each { |rb| require rb }

describe DataSource do
	before(:each) do
		@cmb = Stock.where(:sid => "600036", :market => "sh").first
		@gree = Stock.where(:sid => "000651", :market => "sz").first
		@cnooc = Stock.where(:sid => "00883", :market => "hk").first
	end

	it "should get correct market value for a position" do
		position = Hash.new { |hash, key| hash[key] = {:position => 0, :cost => 0} }
		position[@cmb][:position] = 100
		position[@gree][:position] = 200
		position[@cnooc][:position] = 100
		position[CASH][:position] = 100
		DataSource.yahoo_market_value(position, Date.parse("2012-12-2")).should == 7122.40
	end
end