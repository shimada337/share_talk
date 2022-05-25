class Admin::HouseMembersController < ApplicationController
  before_action :authenticate_admin!
  def destroy
     house_member = HouseMember.find(params[:id])
     if house_member.destroy
      redirect_to request.referer, notice: 'ハウスメンバーを削除しました'
     end
  end
end
