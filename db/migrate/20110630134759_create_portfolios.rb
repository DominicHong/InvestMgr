class CreatePortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolios do |t|
      t.string :name
      t.string :classification
      t.integer :user_id

      t.timestamps
    end
    add_index :portfolios, :user_id
  	add_index :portfolios, :classification
  end

  
  def self.down
    drop_table :portfolios
  end
end
