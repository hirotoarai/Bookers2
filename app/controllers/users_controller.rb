class UsersController < ApplicationController
  
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @book = @user.books
    @book_new = Book.new
    @books = @user.books
  end
  
  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end
  
  def create
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Signed in successfully."
      redirect_to user_path(@user)
    else
      flash[:notice] = "error"
      render :index
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    flash[:notice] = "Signed out successfully."
    redirect_to root_path
    end
  end
  
  def user_params_update
    params.require(:user).permit(:name, :email, :image, :introduction) # introdution追加
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
