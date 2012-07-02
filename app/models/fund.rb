Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

class Fund < Security
  has_many :holdings, :dependent => :destroy,
                      :foreign_key => "fund_id"
  has_many :stocks, :through => :holdings,
  					   :source => "stock_id"
  has_many :funds, :through => :holdings,
                      :source => "fund_id"
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

