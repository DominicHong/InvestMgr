require 'spec_helper'

describe Holding do

  before(:each) do
    @fund = Factory(:fund)
    @stock = Factory(:stock)
    
    @holding = @fund.holdings.build(:stock_id => @stock.id)
  end

  it "should create a new instance given valid attributes" do
    @holding.save!
  end
end

# == Schema Information
#
# Table name: holdings
#
#  id       :integer(4)      not null, primary key
#  stock_id :integer(4)
#  fund_id  :integer(4)
#  hold_at  :datetime
#

