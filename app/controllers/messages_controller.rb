class MessagesController < ApplicationController

  def index
    @all_messages = Message.all
  end

  def create 
    user = User.find(session[:user_id])
    book = Book.find(params[:message][:book_id])
    Message.create(user:user, book:book, content:params[:message][:content])
    redirect_to "/user/#{session[:user_id]}"
  end

  def show
    user = User.find(session[:user_id])
    @messages = Message.find_by_user(user)
  end

  def showOne
    @message = Message.find(params[:id])
    render :json => @message
    # redirect_to posts_new_path
  end

end