class Public::ChatsController < ApplicationController
  before_action :partner_is_exist, only: [:show]

  def index
    @chat_partners = EndUser.where.not(id: current_end_user.id)
  end

  def show
    @end_user = EndUser.find(params[:end_user_id])
    rooms = current_end_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(end_user_id: @end_user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(end_user_id: @end_user.id, room_id: @room.id)
      UserRoom.create(end_user_id: current_end_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_end_user.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def partner_is_exist
    partner = EndUser.find(params[:end_user_id])
    if partner.is_deleted
      redirect_to end_user_chats_path(current_end_user), notice: '相手のユーザーはいません。'
    end
  end

end