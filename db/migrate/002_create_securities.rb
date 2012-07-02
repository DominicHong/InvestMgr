class CreateSecurities < ActiveRecord::Migration
  def self.up
    create_table :securities do |t|
      t.column :sid, :string
      t.column :market, :string
      t.column :name, :string
      t.column :nav, :integer
      t.column :capacity, :integer
      t.column :type, :string

    end
    add_index :securities, [:sid, :market], :unique => true
  end

  def self.down
    drop_table :securities
  end

end
