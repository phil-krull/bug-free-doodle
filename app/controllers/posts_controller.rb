class PostsController < ApplicationController

  def new
    @message = Message.find(params[:id])
    # @post = Post.find_by_message(@message)
  end

  def show
  end

  def create
    message = Message.find(params[:post][:message_id])
    user = User.find(session[:user_id])
    Post.create(user:user, message:message, content:params[:post][:content])
    redirect_to "/posts/#{message.id}"
  end

end