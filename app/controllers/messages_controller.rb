class MessagesController < ApplicationController
  #make sure users are logged in when doing these actions
  before_action :authenticate_user!, only: [:new, :reply, :destroy]
  before_action :set_message, only: [:edit, :update, :destroy]

  # GET /messages
  # GET /messages.json

  #Default to recieved mail
  def index

    @recieved_users = []
    @sent_users = []
    @unique_users = []
    @recieved_users = Message.where(recipient: current_user).select(:owner_id).distinct
    @sent_users =  Message.where(owner: current_user).select(:recipient_id).distinct

    #remove column relationships to id numbers
    unique_id1 = []
    unique_id2 = []
    unique_ids = []

    @recieved_users.each do |user|
      unique_id1.push(user.owner_id) #remove attributes
    end

    @sent_users.each do |user|
      unique_id2.push(user.recipient_id) #remove attributes
    end


    unique_ids = unique_id1 + unique_id2 # combine users that have sent messages to you and users that have recieved messages from you
    unique_ids = unique_ids - (unique_id1 & unique_id2) # remove all instances of duplicates if there are any
    unique_ids = unique_ids + (unique_id1 & unique_id2) # re-add one instance of each duplicate

    unique_ids = unique_ids - [current_user.id] #remove yourself from the list if present

    unique_ids.each do |id| #get the user you have messages with
      @unique_users.push(User.find(id))
    end



  end

  # GET /messages/1
  # GET /messages/1.json
  def show

  end

  def reply

    #get messages in order
    @sent = []
    @recieved = []
    @sent = Message.where(recipient: params[:owner], owner: current_user)
    @recieved = Message.where(recipient: current_user, owner: params[:owner])
    @numsent = 0
    @numrecieved = 0
    @history = []

    while @numsent < @sent.count or @numrecieved < @recieved.count


      if @recieved.count == 0 and @sent.count == 0
        @history = []
        break


      elsif @recieved.count == 0 or @numrecieved == @recieved.count # no messages recieved or all in history
        @history.push(@sent[@numsent])
        @numsent = @numsent + 1


      elsif @sent.count == 0 or @numsent == @sent.count # no messages sent or all sent messages in history
        
        @history.push(@recieved[@numrecieved])
        @numrecieved = @numrecieved + 1
        

      elsif Message.find(@recieved[@numrecieved].id).created_at > Message.find(@sent[@numsent].id).created_at

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
