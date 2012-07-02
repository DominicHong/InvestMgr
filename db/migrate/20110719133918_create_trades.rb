class CreateTrades < ActiveRecord::Migration
  def self.up
    create_table :trades do |t|
      t.integer :portfolio_id, :null => false
      t.integer :state
      t.boolean :buy
      t.string :sell_type
      t.datetime :trade_date
      t.datetime :clear_date
      t.decimal :vol, :precision => 10, :scale => 3 
	  t.decimal :price, :precision => 8, :scale => 3
	  t.decimal :amount, :precision => 12, :scale => 3
	  t.decimal :fee, :precision => 8, :scale => 3
	  t.integer :security_id, :null => false

    end
    add_index :trades, :portfolio_id
  end

  def self.down
    drop_table :trades
  end
end
