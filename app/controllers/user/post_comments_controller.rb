class User::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash.now[:notice] = 'コメントを送信しました'
    else
      render :error
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    if @comment.destroy
     flash.now[:alert] = 'コメントを削除しました'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
