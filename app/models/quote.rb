# == Schema Information
#
# Table name: quotes
#
#  id          :integer(4)      not null, primary key
#  sid         :string(255)
#  market      :string(255)
#  name        :string(255)
#  open        :decimal(8, 3)
#  close       :decimal(8, 3)
#  adjClose    :decimal(8, 3)
#  current     :decimal(8, 3)
#  high        :decimal(8, 3)
#  low         :decimal(8, 3)
#  bid         :decimal(8, 3)
#  ask         :decimal(8, 3)
#  vol         :integer(13)
#  amount      :integer(15)
#  result_date :datetime
#  security_id :integer(4)
#



class Quote < ActiveRecord::Base
	attr_accessible :sid, :market, :name, :open, :close, :adjClose, :current, :high,
					:low, :bid, :ask, :vol, :amount, :result_date, :security
	belongs_to :security

	validates :security_id, :existence => true
	validates :sid, :presence => true
	validates :market, :presence => true
	validates :name, :presence => true
	validates :open, :numericality => {:greater_than_or_equal_to => 0}
	validates :close, :numericality => {:greater_than_or_equal_to => 0}
	#validates :current, :numericality => {:greater_than => 0}
	validates :low, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => :high}
	#validates :bid, :numericality => {:greater_than => 0}
	#validates :ask, :numericality => {:greater_than => 0}
	validates :vol, :numericality => {:greater_than_or_equal_to => 0}
	#validates :amount, :numericality => {:greater_than => 0}

	validates :result_date, :presence => true

	def closeInRMB
		self.close * FxRate::rate(self.result_date.to_date, self.market)
	end
end

