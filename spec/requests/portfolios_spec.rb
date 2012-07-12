require 'spec_helper'

describe "Portfolios" do
  describe "Add a portfolio" do
  	describe "failure" do
  		it "should not add a new portfolio" do
  			lambda do
  				visit new_portfolio_path
  				fill_in 'Name',		:with => ''
  				click_button 'Add a portfolio'
  				page.should have_selector("div.alert.alert-error")
  			end.should_not change(Portfolio, :count) 
  		end
  	end
  	describe "success" do
  		it "should add a new portfolio" do
  			lambda do
  				visit new_portfolio_path
  				fill_in "Name",		:with => "Example Portfolio"
  				select 'AFS', :from => "portfolio_classification"
  				click_button 'Add a portfolio'
  				page.should have_selector("div.alert.alert-success")
  			end.should change(Portfolio, :count).by(1) 
  		end
  	end
  	
  end
end
