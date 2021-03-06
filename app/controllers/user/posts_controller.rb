class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :post_find, only: [:show, :edit, :destroy, :correct_post, :update]
  before_action :correct_post, only: [:edit]
  before_action :search

  def search
    @search_post = Post.ransack(params[:q])
  end

  def new
    @post = Post.new
  end

  def index
    @search_posts = @search_post.result.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '新規投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました'
    else
      flash.now[:alert] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to user_path(current_user), notice: '投稿を削除しました'
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

  # url直打ち対策
  def correct_post
    unless @post.user.id == current_user.id
      redirect_to posts_path, notice: 'あなたの投稿以外の編集画面へは遷移できません'
    end
  end

  def post_find
    @post = Post.find(params[:id])
  end
end
