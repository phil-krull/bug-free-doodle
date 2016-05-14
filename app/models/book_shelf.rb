class BookShelf < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  # has_many :books
end
