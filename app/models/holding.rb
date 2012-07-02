class Holding < ActiveRecord::Base
  belongs_to :fund
  belongs_to :stock
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

