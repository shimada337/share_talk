class User::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_guest_user, only: [:edit]
   before_action :search

  def search
    @search_user = User.ransack(params[:q])
  end
   
  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(5)
    @search_users = @search_user.result.page(params[:page]).per(5).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    #タブメニュー、@userの投稿一覧
    @posts = @user.posts.all.order(created_at: :desc).page(params[:page]).per(5)
    #タブメニュー、@userのハウスメンバー
    @house_members = @user.house_members.all
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)#投稿順にしたい
  end

  def edit
    @user = User.find(params[:id])
    #シェアハウスメンバーの登録と一覧
    @house_member = HouseMember.new
    @house_members = HouseMember.where(user_id: @user.id).all
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :self_introduction, :profile_image, :area, :position)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
