class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end
  def show
  end

  def create
    @user = User.new(user_params)

    @user.save
    redirect_to root_path
  end

  def update
    @user = User.find(params[:id])
  
    if @user.update(book_params)
      redirect_to@user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
   
    redirect_to user_path(@user)
  end
  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
