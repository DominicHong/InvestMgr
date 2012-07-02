Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

class Stock < Security
	has_many :holdings, :dependent => :destroy,
	:foreign_key => "stock_id"


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

