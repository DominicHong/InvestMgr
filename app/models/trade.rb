#  state        :integer(4)		 0 for expired, 1 for not expired
#  buy          :boolean(1)		 0 for sell, 1 for buy
#  sell_type    :string(255)	 FIFO, LIFO, AVG, SPECIFIC
class Trade < ActiveRecord::Base
	after_initialize :default_values
		
	belongs_to :portfolio
	belongs_to :security
	
	validates :portfolio_id, :existence => true
	validates :security_id, :existence => true
	validates :trade_date, :presence => true
	validates :sell_type, :inclusion => [nil, "FIFO","LIFO", "AVG", "SPECIFIC"]
	validates :vol, :numericality => {:greater_than => 0}

	validate :trade_date_must_be_no_later_than_clear_date

	private

	def default_values
		sell_type ||= "AVG"
	end

	def trade_date_must_be_no_later_than_clear_date     
		return false if self.trade_date == nil 
		return true if self.clear_date == nil
		return true if self.trade_date <= self.clear_date
		errors.add(self.trade_date.to_s, "must be no later than clear date") 
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

