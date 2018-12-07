class MessagesController < ApplicationController
  #make sure users are logged in when doing these actions
  before_action :authenticate_user!, only: [:new, :destroy]
  before_action :set_message, only: [:edit, :update, :destroy]

  # GET /messages
  # GET /messages.json

  #Default to recieved mail
  def index

    @messages = Message.where(recipient: current_user)
    @unique_users = Message.where(recipient: current_user).select(:owner_id).distinct
  end

  # GET /messages/1
  # GET /messages/1.json
  def show

  end

  def reply

    #get messages in order
    @sent = Message.where(recipient: params[:owner], owner: current_user)
    @recieved = Message.where(recipient: current_user, owner: params[:owner])
    @numsent = 0
    @numrecieved = 0
    @history = []

    while @numsent < @sent.count and @numrecieved < @recieved.count

      if @recieved[@numrecieved].created_at > @sent[@numsent].created_at
        @history.push(@sent[@numsent])
        @numsent = @numsent + 1
      else
        @history.push(@recieved[@numrecieved])
        @numrecieved = @numrecieved + 1
      end
    end


    @message = Message.new
    @message.recipient = User.find(params[:owner])
    @message.owner = current_user
    render 'new'

  end


  def sent
    @messages = Message.where(owner: current_user)
  end

  # GET /messages/new
  def new

   # @history = Message.where(recipient: current_user, owner: params[:owner]).or(recipient: User.find(params[:owner]), owner: current_user)
    @message.recipient = User.find(params[:owner])
    @message.owner = current_user
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
        format.html { redirect_to messages_reply_path(:owner => @message.recipient) }
        format.json { render :reply, status: :created, location: @message }
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
