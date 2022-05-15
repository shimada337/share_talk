class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :search
  
  def search
    @search_post = Post.ransack(params[:q])
  end
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @search_posts = @search_post.result.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body, :image)
  end
end
