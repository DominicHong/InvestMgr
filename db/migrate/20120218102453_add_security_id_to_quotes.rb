class AddSecurityIdToQuotes < ActiveRecord::Migration
  def self.up
    add_column :quotes, :security_id, :integer
  end

  def self.down
    remove_column :quotes, :security_id
  end
end
