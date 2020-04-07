class BooksController < ApplicationController
    before_action :authenticate_user!
  def index
    @books = Book.all
    @newbook = Book.new
    @user = current_user
    @users = User.all
    @favorite = Favorite.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @newbook = Book.new
    @user = current_user
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
    @favorite = Favorite.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
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
