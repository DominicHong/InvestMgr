class FxRate < ActiveRecord::Base
  attr_accessible :fdate, :market, :rate
  def self.rate(date, market)
  	1 if market == 'sh' || market == 'sz'
  	fx = FxRate.where("fdate = ? AND market = ?", date, market).first
  	fx.nil? ? 1 : fx.rate
  end
end
