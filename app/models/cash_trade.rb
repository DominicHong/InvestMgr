require './app/models/trade.rb'

class CashTrade < Trade
	after_initialize :default_values

	def security
		Cash.first
	end
	
	def vol
		self.amount
	end

	def price
		1
	end
	def cf
		- super
	end

	def adjBalance
		self.cf
	end

	def fee
		0
	end

	private
		def default_values
			self.security = Cash.first
		end

end