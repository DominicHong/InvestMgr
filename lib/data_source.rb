#coding: UTF-8
require 'net/http'

Dir["#{Rails.root.to_s}/lib/*.rb"].each { |rb| require rb }
Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

module DataSource
  def self.yahoo_market_value(position, val_date)
    mv = 0
    position.each { |sec, value| 
      next if sec == CASH
      market = (sec.market == 'sh' ? 'ss' : sec.market) 
      sid = (sec.market == 'hk' ? sec.sid.slice(1,4) : sec.sid)
      date = val_date
      begin
        quotes = YahooFinance::get_HistoricalQuotes( "#{sid}.#{market}", date, date)
        date = date - 1
      end until quotes.size > 0 
      quotes.each {|hq|  mv += value[:position] * FxRate::rate(date, sec.market) * hq.close }
    }
    mv += position[CASH][:position]
  end
end