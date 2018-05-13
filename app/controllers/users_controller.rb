class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:show]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end
end
