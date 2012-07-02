class Portfolio < ActiveRecord::Base
	attr_accessible :name, :classification
	
	belongs_to :user
	has_many :trades, :dependent => :destroy
	validates :name, :presence => true, :uniqueness => {:scope => :user_id} 
	validates :user_id, :presence => true
	validates :classification, :inclusion => %w(TRADING AFS HTM)

	def cash(at = DateTime.now)
		0
	end
	def position(*from, till)
		position = Hash.new { |hash, key| hash[key] = {:position => 0, :cost => 0} }
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

