class BooksController < ApplicationController
    before_action :authenticate_user!
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
    @favorite = Favorite.new
  end

  def show
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
    @book = Book.new
    @user = current_user
    @book_comments = @books.book_comments
    @book_comment = BookComment.new
    @favorite = Favorite.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully created book!"
     redirect_to book_path(@book.id)
   else
    @books = Book.all
    @user = current_user
    render :index
    end
  end


  def edit
    @book = Book.find(params[:id])
    @user = current_user
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = current_user
    if @book.update(book_params)
    flash[:notice] = "successfully updated book!"
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

private
def book_params
    params.require(:book).permit(:title,:body)
end
end
