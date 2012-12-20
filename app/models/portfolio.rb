class Portfolio < ActiveRecord::Base
	attr_accessible :name, :classification
	
	belongs_to :user
	has_many :trades, :dependent => :destroy
	has_many :cash_trades, :dependent => :destroy
	has_many :div_trades, :dependent => :destroy 
	validates :name, :presence => true, :uniqueness => {:scope => :user_id} 
	validates :user_id, :presence => true
	validates :classification, :inclusion => %w(TRADING AFS HTM)

	def change_cash(amount, date)
		amount > 0 ? buy = true : buy = false 
		self.cash_trades.create!(
			:buy => buy, 
			:trade_date => date,
			:clear_date => date,
			:amount => amount.abs )
	end
	def pay_div(amount, date)
		amount > 0 ? buy = true : buy = false 
		self.div_trades.create!(
			:buy => buy, 
			:trade_date => date,
			:clear_date => date,
			:amount => amount.abs )
	end
	def position(*from, till)
		ts = select_trades(*from, till)
		position = Hash.new { |hash, key| hash[key] = {:position => 0, :cost => 0} }
		cash = 0
		position[Cash.first][:position] = cash
		return position	if ts.nil?
		ts.each { |t| 
			vol = position[t.security][:position]
			cost = position[t.security][:cost]
			position[t.security][:position]= (t.buy ? (vol+t.vol) : (vol-t.vol))
			if t.buy
				position[t.security][:cost]=(vol*cost + (t.amount+t.fee))/(vol+t.vol)
			end
			cash += t.cf
		}
		position[Cash.first][:position] = cash
		position
	end
	def nav(*from, till)
		ts = select_trades(*from, till)
		return 0 if ts.nil?
		position = Hash.new { |hash, key| hash[key] = {:position => 0, :cost => 0} }
		cash = 0
		position[Cash.first][:position] = cash
		trade_dates = ts.group_by { |t| t.trade_date.to_date}
		trade_dates.keys.sort.each { |date|
			t =  trade_dates[date]
			vol = position[t.security][:position]
			cost = position[t.security][:cost]
			position[t.security][:position]= (t.buy ? (vol+t.vol) : (vol-t.vol))
			if t.buy
				position[t.security][:cost]=(vol*cost + (t.amount+t.fee))/(vol+t.vol)
			end
			cash += t.cf

		 }

	end

	private
		def select_trades(*from, till)
			rails ArgumentError, "must be no more than ONE from_date" if from.length > 1
			from = from.first
			if from.nil?
				ts = self.trades.where("trade_date <= ?", till).order("trade_date")
			else
				ts = self.trades.where("trade_date >= ? AND trade_date <= ?", from, till).order("trade_date")
			end
		end
end

# == Schema Information
#
# Table name: portfolios
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  classification :string(255)
#  user_id        :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

