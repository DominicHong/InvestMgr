require 'spec_helper'

describe "Portfolios" do

  describe "Add a portfolio" do
  	describe "failure" do
  		it "should not add a new portfolio" do
  			lambda do
  				visit new_portfolio_path
  				fill_in "Name",		:with => ""
  				fill_in "Classification", :with => ""
  				click_button
  				response.should render_template('portfolios/new')
  				response.should have_selector("div#error_explanation")
  			end.should_not change(Portfolio, :count) 
  		end
  	end
  	describe "success" do
  		it "should add a new portfolio" do
  			lambda do
  				visit new_portfolio_path
  				fill_in "Name",		:with => "Example Portfolio"
  				fill_in "Classification", :with => "TRADING"
  				click_button
  				response.should render_template('portfolios')
  				response.should have_selector("div.flash.success",
  												:content => "Successfully")
  			end.should change(Portfolio, :count).by(1) 
  		end
  	end
  	
  end
end
