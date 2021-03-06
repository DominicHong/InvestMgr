# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Stock.create(:market => "sz", :sid=>"000898", :name=>"鞍钢股份").save!
Stock.create(:market => "sh", :sid=>"600019", :name=>"宝钢股份").save!
Stock.create(:market => "sh", :sid=>"600036", :name=>"招商银行").save!
Stock.create(:market => "sh", :sid=>"600000", :name=>"浦发银行").save!
Stock.create(:market => "sh", :sid=>"601398", :name=>"工商银行").save!
Stock.create(:market => "sh", :sid=>"601288", :name=>"农业银行").save!
Stock.create(:market => "sh", :sid=>"601628", :name=>"中国人寿").save!
Stock.create(:market => "sh", :sid=>"601318", :name=>"中国平安").save!
Stock.create(:market => "sh", :sid=>"600028", :name=>"中国石化").save!
Stock.create(:market => "sz", :sid=>"000002", :name=>"万科A").save!
Stock.create(:market => "sh", :sid=>"601088", :name=>"中国神华").save!
Stock.create(:market => "sz", :sid=>"000651", :name=>"格力电器").save!
Stock.create(:market => "sz", :sid=>"000527", :name=>"美的电器").save!
Stock.create(:market => "sh", :sid=>"600377", :name=>"宁沪高速").save!
Stock.create(:market => "sh", :sid=>"600030", :name=>"中信证券").save!
Stock.create(:market => "sh", :sid=>"600518", :name=>"康美药业").save!
Stock.create(:market => "sz", :sid=>"000157", :name=>"中联重科").save!

Stock.create!(:name => "CNOOC", :sid => "00883", :market => "hk")
Stock.create!(:name => "ANTA", :sid => "02020", :market => "hk")
#special security for CASH
Cash.create!(:name => "CASH", :sid => "999", :market => "cash")

#Portfolio and trades for testing NAV computing
@user = User.create!(:name => "Example User", :email => "example@railstutorial.org")
@navport = @user.portfolios.create!(:name => "NAV Shares", :classification => "TRADING")
@cmb = Stock.where(:sid => "600036", :market => "sh").first
@gree = Stock.where(:sid => "000651", :market => "sz").first

@navport.change_cash(10000, DateTime.parse("2012-8-15"))
@navport.trades.create!(:state => 1,
	:buy => true,
	:trade_date => DateTime.parse("2012-9-19"),
	:clear_date => DateTime.parse("2012-9-19"),
	:vol => 200.00,
	:price => 20.00,
	:fee => 5,
	:security_id => @gree.id
	)
@navport.trades.create!(:state => 1,
	:buy => true,
	:trade_date => DateTime.parse("2012-11-2"),
	:clear_date => DateTime.parse("2012-11-2"),
	:vol => 300.00,
	:price => 11.00,
	:fee => 5,
	:security_id => @cmb.id
	)
@navport.trades.create!(:state => 1,
	:buy => true,
	:trade_date => DateTime.parse("2012-11-2 13:00:00"),
	:clear_date => DateTime.parse("2012-11-2 16:00:00"),
	:vol => 100.00,
	:price => 23.00,
	:fee => 5,
	:security_id => @gree.id
	)
@navport.trades.create!(:state => 1,
	:buy => false,
	:trade_date => DateTime.parse("2012-11-20"),
	:clear_date => DateTime.parse("2012-11-20"),
	:vol => 100.00,
	:price => 23.00,
	:fee => 5,
	:security_id => @gree.id
	)
@navport.change_cash(-2000, DateTime.parse("2012-12-2"))
@navport.pay_div(100, DateTime.parse("2012-12-6"))
