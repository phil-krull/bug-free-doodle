class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :posts
end
