#coding: UTF-8
require 'net/http'
require "rubygems"

Dir["#{Rails.root.to_s}/lib/*.rb"].each { |rb| require rb }
Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

class NetDataSource
  #These times are in minutes
  @@amOpen = 9 * 60 + 30
  @@amClose = 11 * 60 + 30
  @@pmOpen = 13 * 60
  @@pmClose = 15 * 60
  @@HOST = "hq.sinajs.cn"
  @@path = "/list="
  
  attr_reader :interval, :run
  attr_writer :interval, :run
  
  def initialize (interval_minutes = 1)
    @run = true
    #@interval is in seconds
    @interval = interval_minutes * 60
  end
  
  def self.pmClose
    return @@pmClose
  end
  
  def checkTime
    now = DateTime.now
    puts "#{now}: Ready to check conditions"
    nowSec = now.hour * 3600 + now.min * 60
    if now.cwday == 6
       sleep(3600 * 24 * 2 - nowSec)
    elsif now.cwday == 7
      sleep(3600 * 24 - nowSec)
    elsif nowSec/60 < @@amOpen
       sleep(@@amOpen * 60 - nowSec)
    elsif (nowSec/60 > @@amClose) && (nowSec/60 < @@pmOpen)
       sleep(@@pmOpen * 60 - nowSec)
    # Close-time-check uses (@@pmClose + 5) to mitigate the price delay
    elsif nowSec/60 > (@@pmClose + 5)
       sleep(3600 * 24 - nowSec) 
    end
    puts "#{now}: I am up and ready to do something."
  end
  
  def retrieveData
    while @run
      begin
        #checkTime
        stocks = Stock.find(:all)
        for stock in stocks do
          getQuote(stock)
        end
        sleep(@interval)
      rescue => e
        puts "Exception raised: " + e.to_s
      end
    end
  end
  
  def getQuote(mystock)
    path = @@path + mystock.market + mystock.sid
    
    httpbody = Net::HTTP.get_response(@@HOST, path).body
    result = httpbody.encode('UTF-8', 'GB2312')
    alist = result.split(",")

    quote = Quote.new
    quote.security = mystock
    quote.sid = mystock.sid
    quote.market = mystock.market
    quote.name = mystock.name
    quote.open = alist[1].to_f
    quote.close = alist[2].to_f
    quote.current = alist[3].to_f
    quote.high = alist[4].to_f
    quote.low = alist[5].to_f
    quote.bid = alist[6].to_f
    quote.ask = alist[7].to_f
    quote.vol = alist[8].to_f
    quote.amount = alist[9].to_f
    quote.result_date = DateTime.strptime((alist[30] + alist[31]),"%Y-%m-%d%H:%M:%S")
    quote.save!
    return quote
  end
  
# Getting the historical quotes.
# The elements of the returned array by yahoofinance are:
#   [0] - Date
#   [1] - Open
#   [2] - High
#   [3] - Low
#   [4] - Close
#   [5] - Volume
#   [6] - Adjusted Close

  def get_historical_quotes(from, to)
  	stocks = Stock.find(:all)
  	for stock in stocks
  		
      market = (sec.market == 'sh' ? 'ss' : sec.market) 
      sid = (sec.market == 'hk' ? sec.sid.slice(1,4) : sec.sid)
  			
  		YahooFinance::get_HistoricalQuotes( "#{sid}.#{market}", 
                                     Date.parse(from),
                                     Date.parse(to) ) {|hq|
  			quote = Quote.new
  			quote.security = stock
  			quote.sid = stock.sid
  			quote.market = stock.market
  			quote.name = stock.name
        quote.result_date = hq.date
  			quote.open = hq.open
  			quote.high = hq.high
  			quote.low = hq.low
  			quote.close = hq.close
  			quote.adjClose = hq.adjClose
  			quote.vol = hq.volume
  			quote.save!
  		}
	  end
  end
end
