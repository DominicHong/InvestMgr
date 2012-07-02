require "active_record"
require "yaml"
require "logger"
require "#{Rails.root.to_s}/vendor/yahoofinance.rb"
#require 'win32ole'

Dir["#{Rails.root.to_s}/lib/*.rb"].each { |rb| require rb }
Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

class DataProcessor
  
  def procDay
    prepare
    stocks = Quotes.find(:all, :order => "sid, result_date")
    stocks.each_index { |i|
      fdate = stocks[i].result_date
      datafile = makeYearMonthDayPath(stocks[i].sid,fdate.year.to_s,fdate.month.to_s,fdate.day.to_s)
      File.open(datafile, File.exist?(datafile) ? "a" : "w") { |f|
        f.puts(stocks[i].sid + "\t"+stocks[i].name + "\t" + stocks[i].open.to_s + "\t" + 
            stocks[i].close.to_s + "\t" + stocks[i].current.to_s + "\t" + stocks[i].max.to_s + "\t" + 
            stocks[i].min.to_s + "\t" + stocks[i].bid.to_s + "\t" + stocks[i].ask.to_s + "\t" + 
            stocks[i].vol.to_s + "\t" + stocks[i].amount.to_s + "\t" + fdate.strftime("%Y-%m-%d-%H:%M:%S")
        )        
      }
      if stocks[i+1]!=nil && stocks[i+1].sid == stocks[i].sid && stocks[i+1].result_date.yday == fdate.yday 
      	then stocks[i].destroy       	
  	end
    }
  end
  
  def transit
    stocks = StockPrice.find(:all)
    for stock in stocks do
      if stock.sid == "898" then stock.sid = "000898" end
      stock.save!
    end
  end
  
 #  def fill_csi300
	# src_file = "#{Rails.root.to_s}/db/000300.xls"
	# sheet_name = "sheet"
 #    excel = WIN32OLE::new('excel.Application')
 #    excel.DisplayAlerts = false
 #    workbook = excel.Workbooks.Open(src_file)
 #    ssheet = workbook.Worksheets(sheet_name)
 #    ssheet.Select
 #    sdata = ssheet.UsedRange.Value
 #    sdata.each_index{|srow|
 #      sid = sdata[srow][0]
 #      name = sdata[srow][1]
 #      market = sdata[srow][3]
 #      market = (market == "Shenzhen") ? "sz" : "sh"
 #      stock = Stock.new
 #      stock.sid = sid
 #      stock.name = name
 #      stock.market = market
 #      stock.save!
 #    }
   
 #    workbook.Close
 #    excel.Quit
 #    excel = nil
 #    GC.start
 #  end
  
  def joinTable
    fund = MyFund.find(:first, :conditions => "sid = '500003'")
    stock = MyStock.find(:first, :conditions => "sid = '000898'")

    fund.my_stocks << stock
  end
  
  
  
  private
  def prepare
    @today = Date.today   
    @homedir = "stock_data"
    makeDir(@homedir)
    
  end
  
  def makeYearMonthDayPath(sid,year,month,day)
    yeardir = File.join(@homedir,year.to_s)
    monthdir = File.join(yeardir,month.to_s)
    daydir = File.join(monthdir,day.to_s)
    makeDir(yeardir)
    makeDir(monthdir)
    makeDir(daydir)
    return File.join(daydir,sid + "-" + year + "-" + month + "-" + day)
  end
  
  def makeDir(mydir)
    Dir.mkdir(mydir) unless(File.exist?(mydir) && File.directory?(mydir))
  end
end