require "#{Rails.root.to_s}/app/models/trade.rb"
require "#{Rails.root.to_s}/app/models/cash_trade.rb"

class DivTrade < CashTrade
	def dividends
		self.cf
	end	

	def adjBalance
		0
	end
end