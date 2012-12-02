# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryGirl.define do
  factory :user do
    name                  "Dominic Hong"
    sequence(:email) {|n|   "person-#{n}@example.com" }                 
  end

  factory :portfolio do 
    sequence(:name) {|n| "A-#{n} Shares"    } 
    classification "TRADING"
    association :user
  end

  factory :security do |security|
    sequence(:sid) { |n| "T6000#{n}6" }
    name "China Commercial Bank "
    market "sh"
  end

  factory :stock do |stock|
    sequence(:sid) {|n| "T00000#{n}"}
    name "Shenzhen Deveopment Bank"
    market "sz"
  end

  factory :fund do |fund|
    sequence(:sid) {|n| "T50000#{n}"}
    name "Anshun Fund"
    market "sh"
  end

  factory :trade do |trade|
    state 1
    buy true
    trade_date DateTime.parse("2011-07-24")
    clear_date DateTime.parse("2011-07-24")
    vol 100.00
    price 20.00
    fee 1.5
    association :portfolio
    association :security
  end
  factory :cash_trade do |cash_trade|
    buy true
    trade_date DateTime.parse("2012-07-19")
    amount 100
    association :portfolio
  end
end