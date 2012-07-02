Dir["#{Rails.root.to_s}/lib/*.rb"].each { |rb| require rb }
Dir["#{Rails.root.to_s}/app/models/*.rb"].each { |rb| require rb }

namespace :utils do
  desc "get realtime stock data from Internet into the database"
  task(:get_quotes => :environment) do
    ds = NetDataSource.new
    ds.retrieveData
  end
  
  desc "get historical stock quotes from Yahoo API"
  task(:get_historical_quotes => :environment) do
   ds = NetDataSource.new
   ds.get_historical_quotes('2003-01-01','2011-5-31')
 end		
 
 desc "transfer stock data from database to file system"
 task(:transfer_stocks => :environment) do
   dp = DataProcessor.new
   dp.procDay
 end
 
 desc "fill CSI300 stocks from Excel"
 task(:fill_csi300 => :environment) do
   dp = DataProcessor.new
   dp.fill_csi300
 end		
 
end