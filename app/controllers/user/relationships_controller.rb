class User::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :search
  
  def search
    @search_user = User.ransack(params[:q])
  end
  # フォローするとき
  def create
    @search_users = @search_user.result.page(params[:page]).per(20).order(created_at: :desc)
     @user = User.find(params[:user_id])
     if current_user.follow(params[:user_id])
       @user.create_notification_follow!(current_user)
      flash.now[:notice] = "#{@user.name}をフォローしました"
     end
  end
  # フォロー外すとき
  def destroy
    @search_users = @search_user.result.page(params[:page]).per(20).order(created_at: :desc)
    @user = User.find(params[:user_id])
    if current_user.unfollow(params[:user_id])
      flash.now[:alert] = "#{@user.name}のフォローを外しました"
    end
  end
  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(20).order(created_at: :desc)
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(20).order(created_at: :desc)
  end
end
