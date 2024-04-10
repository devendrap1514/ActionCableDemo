class MessagesController < ApplicationController
  include Pagy::Backend

  before_action :find_chat_room

  def index
    pagy, messages = pagy(@chat_room.messages, items: 10)
    render json: MessageSerializer.new(messages)
  end

  def create
    message = @chat_room.messages.new(create_params)
    if message.save
      ChatRoomChannel.broadcast_to(chat_room, message)
    else
      render json: { errors: message.errors.full_messages }
    end
  end

  private
  def create_params
    params.permit(:text)
  end

  def find_chat_room
    @chat_room = current_user.chat_rooms.find(params[:chat_room_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Chatroom not found' }
  end
end
