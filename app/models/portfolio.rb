class Portfolio < ActiveRecord::Base
	attr_accessible :name, :classification
	
	belongs_to :user
	has_many :trades, :dependent => :destroy
	has_many :cash_trades, :dependent => :destroy 
	validates :name, :presence => true, :uniqueness => {:scope => :user_id} 
	validates :user_id, :presence => true
	validates :classification, :inclusion => %w(TRADING AFS HTM)

	def cash(at = DateTime.now)
		
	end
	def position(*from, till)
		rails ArgumentError, "must be no more than ONE from_date" if from.length > 2
		from = from.first
		if from.nil?
			ts = self.trades.where("trade_date <= ?", till).order("trade_date")
		else
			ts = self.trades.where("trade_date >= ? AND trade_date <= ?", from, till).order("trade_date")
		end
		position = Hash.new { |hash, key| hash[key] = {:position => 0, :cost => 0} }
		return position	if ts.nil?
		ts.each { |t| 
			vol = position[t.security][:position]
			cost = position[t.security][:cost]
			position[t.security][:position]= (t.buy ? (vol+t.vol) : (vol-t.vol))
			if t.buy
				position[t.security][:cost]=(vol*cost + (t.amount+t.fee))/(vol+t.vol)
			end
		}
		position
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

