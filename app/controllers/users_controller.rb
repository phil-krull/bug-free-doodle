
require 'google/apis/drive_v2'
require 'google/book'
require 'openlibrary'

class UsersController < ApplicationController
  def new
  end

  # not friend user show
  def showOne
    @user = User.find(params[:id])
    @bookshelf = BookShelf.where(user:@user)
  end

  # session user show
  def show
    @user = User.find(params[:id])
    @bookshelf = BookShelf.where(user:@user)
    @friends = Friendship.where(user:@user)
    @messages = Message.where(user:@user)
    friends = [session[:user_id]]
    @friends.each do |friend|
      friends << friend.user_friend_id
    end
    @not_friends = User.where.not(id:friends)
  end

  def create
    user = User.new(create_user)
    if user.valid?
      user.save
      flash[:errors] = ['Thank you for registering, please login to continue']
    else
      flash[:errors] = user.errors.full_messages
    end
      redirect_to root_path
  end

  private

  def create_user
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
