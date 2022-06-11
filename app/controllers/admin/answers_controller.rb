class Admin::AnswersController < ApplicationController
  def destroy
    board = Board.find(params[:board_id])
    answer = Answer.find_by(id: params[:id], board_id: params[:board_id])
    answer.destroy
    redirect_to admin_board_path(board), notice: '回答を削除しました'
  end
end
