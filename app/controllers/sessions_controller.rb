class SessionsController < ApplicationController

  def new
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.first_name
      redirect_to "/user/#{session[:user_id]}"
    else
      flash[:errors] = ['Email and/or password are invalid']
      redirect_to users_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to root_path
  end

end
