class User::AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    board = Board.find(params[:board_id])
    answer = current_user.answers.new(answer_params)
    answer.board_id = board.id
    if answer.save
      redirect_to board_path(board), notice: '回答を送信しました'
    else
      redirect_to board_path(board), alert: '回答の送信に失敗しました'
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    answer = Answer.find_by(id: params[:id], board_id: params[:board_id])
    answer.destroy
    redirect_to board_path(board), notice: '回答を削除しました'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
