#coding: UTF-8
require 'active_record/fixtures'
class LoadMystocksData < ActiveRecord::Migration
  def self.up
    down

    Fund.create(:market => "sh",  :sid=>"500003", :name=>"基金安信").save!
    Fund.create(:market => "sh",  :sid=>"500009", :name=>"基金安顺").save!
  end

  def self.down
    Stock.delete_all 
  end
end
