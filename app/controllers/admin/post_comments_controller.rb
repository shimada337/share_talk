class Admin::PostCommentsController < ApplicationController
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
