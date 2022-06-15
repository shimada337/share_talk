class User::BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @board = Board.new
    @boards = Board.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    # 掲示板の回答数のランキング
    @board_answer_ranks = Board.find(Answer.group(:board_id).order('count(board_id) desc').limit(5).pluck(:board_id))
  end

  def show
    @board = Board.find(params[:id])
    @answer = Answer.new
    @answers = @board.answers.order(created_at: :desc).page(params[:page]).per(20)
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to boards_path, notice: '掲示板を作成しました'
    else
      @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      @board_answer_ranks = Board.find(Answer.group(:board_id).order('count(board_id) desc').limit(5).pluck(:board_id))
      flash.now[:alert] = '掲示板の作成に失敗しました'
      render :index
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path, notice: '掲示板を削除しました'
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end
end
