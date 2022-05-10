class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "ユーザー情報を更新しました"
    redirect_to admin_user_path(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :is_deleted)
  end
end
