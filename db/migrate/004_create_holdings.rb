class CreateHoldings < ActiveRecord::Migration
  def self.up
    create_table :holdings do |t|
      t.column :stock_id, :integer
      t.column :fund_id, :integer
      t.column :hold_at, :datetime
    end

  end

  def self.down
    drop_table :holdings
  end
end
