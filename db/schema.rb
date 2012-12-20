# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121220104928) do

  create_table "fx_rates", :force => true do |t|
    t.date    "fdate"
    t.string  "market"
    t.decimal "rate",   :precision => 8, :scale => 4
  end

  add_index "fx_rates", ["fdate", "market"], :name => "index_fx_rates_on_fdate_and_market", :unique => true

  create_table "holdings", :force => true do |t|
    t.integer  "stock_id"
    t.integer  "fund_id"
    t.datetime "hold_at"
  end

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.string   "classification"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "portfolios", ["classification"], :name => "index_portfolios_on_classification"
  add_index "portfolios", ["user_id"], :name => "index_portfolios_on_user_id"

  create_table "quotes", :force => true do |t|
    t.string   "sid"
    t.string   "market"
    t.string   "name"
    t.decimal  "open",        :precision => 8,  :scale => 3
    t.decimal  "close",       :precision => 8,  :scale => 3
    t.decimal  "adjClose",    :precision => 8,  :scale => 3
    t.decimal  "current",     :precision => 8,  :scale => 3
    t.decimal  "high",        :precision => 8,  :scale => 3
    t.decimal  "low",         :precision => 8,  :scale => 3
    t.decimal  "bid",         :precision => 8,  :scale => 3
    t.decimal  "ask",         :precision => 8,  :scale => 3
    t.decimal  "vol",         :precision => 13, :scale => 0
    t.decimal  "amount",      :precision => 15, :scale => 0
    t.datetime "result_date"
    t.integer  "security_id"
  end

  add_index "quotes", ["sid", "market", "result_date"], :name => "index_quotes_on_sid_and_market_and_result_date", :unique => true

  create_table "securities", :force => true do |t|
    t.string  "sid"
    t.string  "market"
    t.string  "name"
    t.integer "nav"
    t.integer "capacity"
    t.string  "type"
  end

  add_index "securities", ["sid", "market"], :name => "index_securities_on_sid_and_market", :unique => true

  create_table "trades", :force => true do |t|
    t.integer  "portfolio_id",                                :null => false
    t.integer  "state"
    t.boolean  "buy"
    t.string   "sell_type"
    t.datetime "trade_date"
    t.datetime "clear_date"
    t.decimal  "vol",          :precision => 10, :scale => 3
    t.decimal  "price",        :precision => 8,  :scale => 3
    t.decimal  "amount",       :precision => 12, :scale => 3
    t.decimal  "fee",          :precision => 8,  :scale => 3
    t.integer  "security_id",                                 :null => false
    t.string   "type"
  end

  add_index "trades", ["portfolio_id"], :name => "index_trades_on_portfolio_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
