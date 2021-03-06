class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]
  before_action :search

  def search
    @search_user = User.ransack(params[:q])
  end

  def index
    @search_users = @search_user.result.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # タブメニュー、@userの投稿一覧
    @posts = @user.posts.order(created_at: :desc).page(params[:my_posts]).per(20)
    @all_posts = @user.posts
    # タブメニュー、@userのハウスメンバー
    @house_members = @user.house_members
    # タブメニュー、@userのいいね一覧
    @favorite_posts = Post.joins(:favorites).where(favorites: { user_id: @user.id }).order(created_at: :desc).page(params[:favorite_posts]).per(20)
    @all_favorite_posts = @user.favorites
  end

  def edit
    @user = User.find(params[:id])
    # シェアハウスメンバーの登録
    @house_member = HouseMember.new
    # シェアハウスメンバーの一覧
    @house_members = HouseMember.where(user_id: @user.id)
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

  # url直打ち対策
  def correct_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーのプロフィール編集画面へは遷移できません'
    elsif @user != current_user
      redirect_to user_path(current_user), notice: 'あなた以外のユーザーの編集画面へは遷移できません'
    end
  end
end
