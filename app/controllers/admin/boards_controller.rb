class Admin::BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @board = Board.find(params[:id])
    @answers = @board.answers
  end
  
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to admin_boards_path, notice: '掲示板を削除しました'
  end
end
