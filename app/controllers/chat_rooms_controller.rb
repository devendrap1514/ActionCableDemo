class ChatRoomsController < ApplicationController
  before_action :find_chat_room
  def create
    chat_room = current_user.chat_rooms.new(create_params)
    if chat_room.save
      # broadcast
    else
      render json: { errors: chat_room.errors.full_messages }
    end
  end

  def show
    render json: ChatRoomSerialzer.new(@chat_room)
  end

  private
  def create_params
    params.permit(:title)
  end

  def find_chat_room
    @chat_room = current_user.chat_rooms.find(params[:chat_room_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Chat room not found' }
  end
end
