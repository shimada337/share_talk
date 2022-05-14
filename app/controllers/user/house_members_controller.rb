class User::HouseMembersController < ApplicationController
  def new
  end

  def edit
  end
  
  def create
    @house_member = HouseMember.new(house_member_params)
    @house_member.user_id = current_user.id
    @house_member.save
    redirect_to request.referer
  end
  
  def destroy
    @house_member = HouseMember.find(params[:id])
    @house_member.destroy
    redirect_to request.referer
  end
  
  private
  
  def house_member_params
    params.require(:house_member).permit(:name, :introduction, :position)
  end
end
