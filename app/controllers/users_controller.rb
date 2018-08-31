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

  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
