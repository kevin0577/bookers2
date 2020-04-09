class UsersController < ApplicationController
	before_action :authenticate_user!
def show
  @newbook = Book.new
  @user = User.find(params[:id])
  @books = @user.books
end
def edit
	@user = User.find(params[:id])
  if@user.id != current_user.id
  redirect_to user_path(current_user.id)
  end
end
def update
  @user = User.find(params[:id])
  if @user.update(user_params)
     flash[:notice] = "successfully updated user!"
    redirect_to user_path
  else
    render :edit
    end
end
def index
    @users = User.all
    @user = current_user
    @newbook = Book.new
end
def follows
    @user = User.find(params[:user_id])
end
def follower
    @user = User.find(params[:user_id])
end

private
def user_params
  params.require(:user).permit(:introduction, :name, :profile_image)
end
end
