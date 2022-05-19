class User::NotificationsController < ApplicationController
  # before_action :correct_notification,only: [:index]
  def index
     @notifications = current_user.passive_notifications.page(params[:page]).per(20)
     @notifications.where(checked: false).each do |notification|
       notification.update(checked: true)
     end
  end
  
  # private
  
  # def correct_notification
  #   @notification = Notification.find(params[:id])
  #   unless @notification.visited_id == current_user.id
  #     redirect_to user_path(current_user), notice: 'あなた以外の通知画面へ遷移できません'
  #   end
  # end
end
