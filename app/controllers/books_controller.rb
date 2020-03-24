class BooksController < ApplicationController
    before_action :authenticate_user!
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
    @book = Book.new
end

  def new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "successfully"
     redirect_to book_path(book.id)
   else
    @book = book
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
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

private
def book_params
    params.require(:book).permit(:title,:body)
end

def ensure_correct_user
  @book = Book.find_by(id: params[:id])
  if @book.user_id != @current_user.id
  flash[:notice] = "権限がありません"
  redirect_to("/books/index")
end
end
end
