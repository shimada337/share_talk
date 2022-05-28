class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :search
  
  def search
    @search_post = Post.ransack(params[:q])
  end
  
  def index
    @search_posts = @search_post.result.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path, notice: '投稿を削除しました'
    end
  end
end
