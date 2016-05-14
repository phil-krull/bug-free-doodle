class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :user_friend, index: true

      t.timestamps null: false
    end
    add_foreign_key :friendships, :users, column: :user_friend_id
    add_index :friendships, [:user_id, :user_friend_id], unique: true
  end
end
