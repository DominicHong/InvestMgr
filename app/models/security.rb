class Security < ActiveRecord::Base
	has_many :trades, :dependent => :destroy
	has_many :quotes, :dependent => :destroy
	attr_accessible :market, :name, :sid

    def ==(s)               # Is self == s?
  		if s.is_a? Security      # If s is a Security object
    		self.sid==s.sid && self.market==s.market  # then compare the fields.
  		elsif                 # If s is not a Security
    		false               # then, by definition, self != s.
		end
	end
	
	def eql?(s)               # The same as above
  		if s.is_a? Security      
    		self.sid==s.sid && self.market==s.market  
  		elsif                
    		false            
		end
	end

	def hash
		code = 17
		code = 37 * code + self.sid.hash
		code = 37 * code + self.market.hash
		code
	end
end
# == Schema Information
#
# Table name: securities
#
#  id       :integer(4)      not null, primary key
#  sid      :string(255)
#  market   :string(255)
#  name     :string(255)
#  nav      :integer(4)
#  capacity :integer(4)
#  type     :string(255)
#

