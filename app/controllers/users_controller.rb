class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.all
  	#@user = User.find(current_user.id)
  	@book = Book.new
  end

  def show
  	#@books= Book.all
  	@user = User.find(params[:id])
  	@books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      flash[:notice] = 'You have updated user successfully.'
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
