class Book < ActiveRecord::Base
  belongs_to :author
  # belongs_to :book_shelf
  has_many :book_shelfs
  has_many :users, through: :book_shelfs
  has_many :messages
end
