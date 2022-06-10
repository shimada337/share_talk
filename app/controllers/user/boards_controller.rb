class User::BoardsController < ApplicationController
  def index
    @board = Board.new
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show
    @board = Board.find(params[:id])
  end
  
  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to boards_path, notice: 'ボードを作成しました'
    else
      redirect_to boards_path, alert: 'ボードの作成に失敗しました'
    end
  end
  
  def destroy
  end
  
  private
  
  def board_params
    params.require(:board).permit(:title)
  end
end
