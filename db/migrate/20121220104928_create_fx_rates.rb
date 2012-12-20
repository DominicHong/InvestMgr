class CreateFxRates < ActiveRecord::Migration
  def change
    create_table :fx_rates do |t|
      t.date :fdate
      t.string :market
      t.decimal :rate, :precision => 8, :scale => 4 
    end
    add_index :fx_rates, [:fdate, :market], :unique => true
  end
end
