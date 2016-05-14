class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_friend, :foreign_key => "user_friend_id", class_name: "User"
end
