require './app/models/trade.rb'
require './app/models/cash_trade.rb'

class DivTrade < CashTrade
	def dividends
		self.cf
	end	

	def adjBalance
		0
	end
end