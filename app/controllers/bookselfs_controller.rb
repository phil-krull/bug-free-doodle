require 'json'

class BookselfsController < ApplicationController

  def new
    @user = User.find(session[:user_id])
  end

  def show
    # check to see if the user owns the book
    user = User.find(session[:user_id])
    title = params[:book][:title]
    book = Book.find_by_title(title)
    if book.nil?
      response = false
    else
      userbook = BookShelf.where(user:user, book:book)
    end
    if userbook
      response = true
    else
      response = false
    end
    render :html => response
  end

  def create
    user = User.find(session[:user_id])
      # check to see if the author exists
      if Author.find_by_name(params[:book][:author]) == nil
        author = Author.create(name:params[:book][:author])
      else
        author = Author.find_by_name(params[:book][:author])
      end
      # check to see if book exists
      if Book.find_by_isbn(params[:book][:isbn]) == nil
        book = Book.new( create_bookshelf )
        book.author = author
        book.save
      else
        book = Book.find_by_isbn(params[:book][:isbn])
      end
    BookShelf.create(user:user, book:book)
    # redirect_to "/user/#{session[:user_id]}"
    redirect_to bookselfs_new_path
  end

  def create_bookshelf
    params.require(:book).permit(:title, :year, :isbn, :image, :description)
  end
end
