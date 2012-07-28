Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

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
		self.amount
	end
	def is_cash?
		true
	end

	private
		def default_values
			self.security = Cash.first
		end

end