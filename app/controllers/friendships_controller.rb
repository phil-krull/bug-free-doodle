class FriendshipsController < ApplicationController
  def new
    @users = User.all
    user = User.find(session[:user_id])
    @friends = Friendship.where(user:user)
  end

  def show
    @friend = User.find(params[:id])
    @friendbooks = User.find(@friend).books
  end

  def create
    user = User.find(session[:user_id])
    friend = User.find(params[:friend_id])
    Friendship.create(user:user, user_friend:friend)
    redirect_to "/user/#{session[:user_id]}"
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to "/user/#{session[:user_id]}"
  end
end
