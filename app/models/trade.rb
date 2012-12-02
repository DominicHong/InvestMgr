#  state        :integer(4)		 0 for expired, 1 for not expired
#  buy          :boolean(1)		 0 for sell, 1 for buy
#  sell_type    :string(255)	 FIFO, LIFO, AVG, SPECIFIC
class Trade < ActiveRecord::Base
	before_validation :default_values
		
	belongs_to :portfolio
	belongs_to :security
	
	validates :buy, :inclusion => {:in => [true, false]}
	validates :portfolio_id, :existence => true
	validates :security_id, :existence => true
	validates :trade_date, :presence => true
	validates :sell_type, :inclusion => [nil, "FIFO","LIFO", "AVG", "SPECIFIC"]
	validates :vol, :numericality => {:greater_than_or_equal_to => 0},
					:unless => Proc.new{|trade| trade.type == "CashTrade"} 
	validates :price, :numericality => {:greater_than_or_equal_to => 0},
					:unless => Proc.new{|trade| trade.type == "CashTrade"} 				
	validates :amount,  :numericality => {:greater_than_or_equal_to => 0}
	validate :trade_date_must_be_no_later_than_clear_date

	# Return cashflow for this trade
	def cf
		self.buy ? (-self.amount-self.fee)  : (self.amount - self.fee)
	end
	def is_cash?
		false
	end



	private

		def default_values
			self.sell_type ||= "AVG"
			self.amount ||= self.vol * self.price
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

