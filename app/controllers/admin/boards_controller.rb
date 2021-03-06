class Admin::BoardsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @boards = Board.includes(:user).order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @board = Board.find(params[:id])
    @answers = @board.answers.order(created_at: :desc).page(params[:page]).per(20)
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to admin_boards_path, notice: '掲示板を削除しました'
  end
end
