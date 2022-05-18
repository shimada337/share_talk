class User::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_guest_user, only: [:edit]
   before_action :search

  def search
    @search_user = User.ransack(params[:q])
  end
   
  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
    @search_users = @search_user.result.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    #タブメニュー、@userの投稿一覧
    @posts = @user.posts.all.order(created_at: :desc).page(params[:my_posts]).per(20)
    #タブメニュー、@userのハウスメンバー
    @house_members = @user.house_members.all
    @favorite_posts = Post.joins(:favorites).where(favorites: {user_id: @user.id}).order(created_at: :desc).page(params[:favorite_posts]).per(30)
  end

  def edit
    @user = User.find(params[:id])
    #シェアハウスメンバーの登録と一覧
    @house_member = HouseMember.new
    #シェアハウスメンバーの一覧
    @house_members = HouseMember.where(user_id: @user.id).all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'ユーザー情報を更新しました'
    else
      @house_member = HouseMember.new
      @house_members = HouseMember.where(user_id: @user.id).all
      flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
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
