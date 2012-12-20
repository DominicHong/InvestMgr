class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.column :sid, :string 
      t.column :market, :string
      t.column :name, :string
      t.column :open, :decimal, :precision => 8, :scale => 3
      t.column :close, :decimal, :precision => 8, :scale => 3
      t.column :adjClose, :decimal, :precision => 8, :scale => 3
      t.column :current, :decimal, :precision => 8, :scale => 3
      t.column :high, :decimal, :precision => 8, :scale => 3
      t.column :low, :decimal, :precision => 8, :scale => 3
      t.column :bid, :decimal, :precision => 8, :scale => 3
      t.column :ask,:decimal, :precision => 8, :scale => 3 
      t.column :vol, :decimal, :precision => 13
      t.column :amount, :decimal, :precision => 15
      t.column :result_date, :datetime
      t.references :security
    end
    add_index :quotes, [:sid, :market, :result_date], :unique => true
    add_index :quotes, :security_id
  end

  def self.down
    drop_table :quotes
  end
end
