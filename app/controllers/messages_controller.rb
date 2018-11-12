class MessagesController < ApplicationController
  #make sure users are logged in when doing these actions
  before_action :authenticate_user!, only: [:new, :destroy]
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json

  #Default to recieved mail
  def index
    @messages = Message.where(recipient: current_user)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show

    if(@message.recipient == current_user)
      @message.read = true
      Message.update(@message.id, :read => true)
    end

    @messages = []
    parent = @message
    @messages.push(parent)
  

    while parent.parent_id != 0  and parent.parent_id != nil

      parent = Message.find(parent.parent_id)
      @messages.push(parent)

    end
  end

  def reply
    @message = Message.new
    render 'new'

  end


  def sent
    @messages = Message.where(owner: current_user)
  end

  # GET /messages/new
  def new
    @message = Message.new

  end
  # POST /messages
  # POST /messages.json
  def create

    @message = Message.new(message_params)
    @message.owner = current_user
    @message.read = false

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :owner_id, :recipient_id, :read, :user_id, :parent_id)
    end
end
