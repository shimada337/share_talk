class User::RoomsController < ApplicationController
  def index
    @user = User.all
    @current_user_rooms = current_user.user_rooms
    myRoomIds = [ ]
    
    @current_user_rooms.each do |user_room|
      myRoomIds << user_room.id
    end
    
    # binding.pry
    @another_user_rooms = UserRoom.where(room_id: myRoomIds).where('user_id != ?', @user.ids)
  end
end
