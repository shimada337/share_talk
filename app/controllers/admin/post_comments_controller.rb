class Admin::PostCommentsController < ApplicationController
  def destroy
     post_comment = PostComment.find(params[:id])
     if post_comment.destroy
      redirect_to request.referer, notice: 'コメントを削除しました'
     end
  end
end
