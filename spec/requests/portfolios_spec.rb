#coding: UTF-8
require 'spec_helper'

describe "Portfolios" do
  subject { page }
  describe "Add a portfolio" do
    describe "failure" do
      it "should not add a new portfolio" do
        lambda do
          visit new_portfolio_path
          fill_in 'Name',   :with => ''
          click_button 'Add a portfolio'
          should have_selector("div.alert.alert-error")
        end.should_not change(Portfolio, :count)
      end
    end
    describe "success" do
      it "should add a new portfolio" do
        lambda do
          visit new_portfolio_path
          fill_in "Name",   :with => "Example Portfolio"
          select 'AFS', :from => "portfolio_classification"
          click_button 'Add a portfolio'
          should have_selector("div.alert.alert-success")
        end.should change(Portfolio, :count).by(1)
      end
    end
  end
  describe "in portfolio Mainland Shares" do
    before do
      visit portfolios_path
      click_link('Mainland Shares')
    end

    it { should have_selector 'h1',text: 'Mainland Shares'}
    it { should have_selector 'table tr', minimum: 1}
    it "should display correct positions" do
      should have_table 'positions'
      should have_selector 'td', text: '600036'
      should have_selector 'td', text: 'sh'
      should have_link '招商银行'
    end
  end

end
