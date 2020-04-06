class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
    redirect_back(fallback_location: root_path)
  end
  def destroy
    @favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    @book = Book.find(params[:book_id])
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end
