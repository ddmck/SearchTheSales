class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json


  def index
    if current_admin
      @message = User.find(params[:id]).messages.where(user_id: params[:adminId])
      respond_with(@messages, status: 200)
    elsif current_user
      @messages = current_user.messages
      respond_with(@messages, status: 200)
    else
      @messages = []
      respond_with(@messages, status: 401)
    end
  end

  def show
    respond_with(@message)
  end

  def new
    @message = Message.new
    respond_with(@message)
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    puts @message.attributes
    if @message.save
      respond_with(@message, status: 200)
    else
      respond_with(@message, status: 500)
    end
  end

  def update
    @message.update(message_params)
    respond_with(@message)
  end

  def destroy
    @message.destroy
    respond_with(@message)
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:text, :user_id, :seen)
    end
end
