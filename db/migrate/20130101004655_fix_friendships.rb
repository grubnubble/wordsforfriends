class FixFriendships < ActiveRecord::Migration
  def change
    remove_column :friendships, :id
    rename_column :friendships, :user1_id, :user_id
    rename_column :friendships, :user2_id, :friend_id
  end
end
