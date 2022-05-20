class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_post,only: [:edit]
  before_action :search
  
  def search
    @search_post = Post.ransack(params[:q])
  end
  
  def new
    @post = Post.new
  end

  def index
    # @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
    @search_posts = @search_post.result.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました'
    else
      flash.now[:alert] = '投稿の更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: '投稿を削除しました'
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body, :image)
  end
  
  #url直打ち対策
  def correct_post
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path, notice: 'あなたの投稿以外の編集画面へは遷移できません'
    end
  end
end
