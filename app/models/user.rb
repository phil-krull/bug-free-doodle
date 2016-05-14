class User < ActiveRecord::Base
  has_secure_password
  has_many :books, :through => :book_shelfs
  has_many :book_shelfs
  has_many :friendships
  has_many :friends, through: :friendships, source: :user_friend
  has_many :messages
  validates_presence_of :first_name, :last_name, :email, :password, :on => :create
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, :uniqueness => { case_sensitive: false }, :format => { :with => email_regex }
end
