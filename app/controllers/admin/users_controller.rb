class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :search
  
  def search
    @search_user = User.ransack(params[:q])
  end
  
  def index
    # @users = User.all.page(params[:page]).per(5)
    @search_users = @search_user.result.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :profile_image, :is_deleted)
  end
end
