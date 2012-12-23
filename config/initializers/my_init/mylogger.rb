logfile = File.open(Rails.root.to_s + "/log/mylogger.log", "a") 
logfile.sync = true
MYLOG = Logger.new(logfile, 1)
