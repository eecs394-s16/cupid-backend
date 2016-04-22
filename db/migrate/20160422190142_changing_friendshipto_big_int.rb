class ChangingFriendshiptoBigInt < ActiveRecord::Migration
  def change
    change_column :friendships, :friend_id, :bigint
    change_column :friendships, :user_id, :bigint
  end
end
