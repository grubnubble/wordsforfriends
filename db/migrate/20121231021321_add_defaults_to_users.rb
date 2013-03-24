class AddDefaultsToUsers < ActiveRecord::Migration
  def up
    change_column( :writings, :global_r, :boolean, { :default => false })
    change_column( :writings, :friends_r, :boolean, { :default => false })
    change_column( :users, :active, :boolean, { :default => false })
  end
  def down
    change_column( :writings, :global_r, :boolean, {}) 
    change_column( :writings, :friends_r, :boolean, {})
    change_column( :users, :active, :boolean, {})
  end
end
