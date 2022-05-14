class User::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    #タブメニュー、@userの投稿一覧
    @posts = @user.posts.all.order(created_at: :desc).page(params[:page]).per(5)
    #タブメニュー、@userのハウスメンバー
    @house_members = @user.house_members.all
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
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
