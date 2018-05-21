class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :myart, :update]
  before_action :correct_user, only: [:show, :myart]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to @user
    else
      render :show
    end
  end
  
  def myarts
    @favorites = current_user.favorite_items
    @readlaters = current_user.readlater_items
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
