class User::HouseMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_house_member, only: [:edit]

  def edit
    @user = current_user
    @house_member = HouseMember.find(params[:id])
  end

  def create
    @house_member = HouseMember.new(house_member_params)
    @house_member.user_id = current_user.id
    if @house_member.save
      redirect_to request.referer, notice: 'シェアハウスメンバーを登録しました'
    else
      flash[:alert] = 'シェアハウスメンバーの登録に失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
    @house_member = HouseMember.find(params[:id])
    if @house_member.destroy
      redirect_to request.referer, notice: 'シェアハウスメンバーを削除しました'
    end
  end

  def update
    @house_member = HouseMember.find(params[:id])
    if @house_member.update(house_member_params)
      redirect_to edit_user_path(current_user), notice: 'シェアハウスメンバーの情報を更新しました'
    else
      flash[:alert] = 'シェアハウスメンバーの情報更新に失敗しました'
      redirect_to request.referer
    end
  end

  private

  def house_member_params
    params.require(:house_member).permit(:name, :introduction, :position)
  end
  
  def correct_house_member
    @house_member = HouseMember.find(params[:id])
    unless @house_member.user_id == current_user.id
      redirect_to user_path(current_user.id), notice: 'あなた以外のシェアハウスメンバーの編集画面へは遷移できません'
    end
  end
end
