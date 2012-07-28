namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_stocks
    make_portfolios
    make_trades
  end
  def make_users
    @user = User.create!(:name => "Example User", :email => "example@railstutorial.org")

    # 99.times do |n|
    #       name  = Faker::Name.name
    #       email = "example-#{n+1}@railstutorial.org"
    #       User.create!(:name => name, :email => email)
    #     end
  end
  def make_stocks
    #Rake::Task['utils:fill_csi300'].invoke
  end
  def make_portfolios
    @mainport = @user.portfolios.create!(:name => "Mainland Shares", :classification => "TRADING")
    @hkport = @user.portfolios.create!(:name => "Hongkong Shares", :classification => "TRADING")
    @usport = @user.portfolios.create!(:name => "US Shares", :classification => "TRADING")
    5.times do |n|
      @user.portfolios.create!(:name => Faker::Company.bs, :classification => "TRADING")
    end
    5.times do |n|
      @user.portfolios.create!(:name => Faker::Company.bs, :classification => "AFS")
    end
    5.times do |n|
      @user.portfolios.create!(:name => Faker::Company.catch_phrase, :classification => "HTM")
    end
  end

  def make_trades
    @cmb = Stock.where(:sid => "600036", :market => "sh").first
    @gree = Stock.where(:sid => "000651", :market => "sz").first
    @cnooc = Stock.where(:sid => "00883", :market => "hk").first
    @anta = Stock.where(:sid => "02020", :market => "hk").first
    tdate = DateTime.parse("2012-3-4")
    #Buy GREE in the mainland portfolio
    @mainport.trades.create!(:state => 1,
                             :buy => true,
                             :trade_date => tdate,
                             :clear_date => tdate,
                             :vol => 100.00,
                             :price => 19.00,
                             :amount => 100 * 19.00 +1.5,
                             :fee => 1.5,
                             :security_id => @gree.id
                             )
    #Buy CMB in the mainland portfolio 5 times in consecutive days
    5.times do |n|
      n = n + 1
      @mainport.trades.create!(:state => 1,
                               :buy => true,
                               :trade_date => tdate.next_day(n),
                               :clear_date => tdate.next_day(n),
                               :vol => 100.00 * n,
                               :price => 20.00 * (1 + n.to_f/100),
                               :amount => 100 * n * 20.00 * (1 + n.to_f/100) +1.5 * n,
                               :fee => 1.5 * n,
                               :security_id => @cmb.id
                               )
    end
    tdate = DateTime.parse("2012-3-5")
    #Sell Gree in the mainland portfolio
    @mainport.trades.create!(:state => 1,
                             :buy => false,
                             :trade_date => tdate.next_day(1),
                             :clear_date => tdate.next_day(1),
                             :vol => 100.00,
                             :price => 20.00,
                             :amount => 100.00 * 20.00 - 1.5,
                             :fee => 1.5,
                             :security_id => @gree.id
                             )
    #Sell CMB in the mainland portfolio 4 times in consecutive days
    4.times do |n|
      n = n + 1
      @mainport.trades.create!(:state => 1,
                               :buy => false,
                               :trade_date => tdate.next_day(n).advance(:hours => 3),
                               :clear_date => tdate.next_day(n).advance(:hours => 3),
                               :vol => 100.00 * n,
                               :price => 20.00 * (1 + n.to_f/100),
                               :amount => 100.00 * n * 20.00 * (1 + n.to_f/100) - 1.5 * n,
                               :fee => 1.5 * n,
                               :security_id => @cmb.id
                               )
    end
    #Buy CNOOC in the hongkong portfolio 5 times in consecutive days
    tdate = DateTime.parse("2012-3-4")
    5.times do |n|
      n = n + 1
      @hkport.trades.create!( :state => 1,
                              :buy => true,
                              :trade_date => tdate.next_day(n),
                              :clear_date => tdate.next_day(n),
                              :vol => 100.00 * n,
                              :price => 25.00 * (1 + n.to_f/100),
                              :amount => 100.00 * n * 25.00 * (1 + n.to_f/100) + 1.5 * n,
                              :fee => 1.5 * n,
                              :security_id => @cnooc.id
                              )
    end
    #Sell CNOOC in the hongkong portfolio 4 times in consecutive days
    tdate = DateTime.parse("2012-3-5")
    4.times do |n|
      n = n + 1
      @hkport.trades.create!( :state => 1,
                              :buy => false,
                              :trade_date => tdate.next_day(n).advance(:hours => 3),
                              :clear_date => tdate.next_day(n).advance(:hours => 3),
                              :vol => 100.00 * n,
                              :price => 25.00 * (1 + n.to_f/100),
                              :amount => 100 * n * 25.00 *(1 + n.to_f/100) - 1.5 * n,
                              :fee => 1.5 * n,
                              :security_id => @cnooc.id
                              )
    end
  end
end
