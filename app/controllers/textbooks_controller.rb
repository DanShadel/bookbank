class TextbooksController < ApplicationController
  #make sure users are logged in when doing these actions
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  #find the correct listing when doing these actions
  before_action :set_textbook, only: [:show, :edit, :update, :destroy]

  # GET /textbooks
  # GET /textbooks.json
  def index
    if(params[:category])
      @textbooks = []
      search = Textbook.all

      fz = FuzzyMatch.new(search, :read => params[:category])
      query = fz.find(params[:input])

      while query != nil
    
        @textbooks.push(query)
        search -= [query]

        fz = FuzzyMatch.new(search, :read => params[:category])
        query = fz.find(params[:input])
        
      end
     
      
    else
      @textbooks = Textbook.all
   end
  end

  # GET /textbooks/1
  # GET /textbooks/1.json
  def show
  end

  # GET /textbooks/new
  def new
    @textbook = Textbook.new
    
  end

  # GET /textbooks/1/edit
  def edit
    #Check if the user owns the textbook
    wrong_user_check

  end

  # POST /textbooks
  # POST /textbooks.json
  def create
    @textbook = Textbook.new(textbook_params)
    @textbook.user = current_user
    @textbook.amazon = (Random.rand(75) + 25)
    if @textbook.price >= 10000
        @textbook.price = 10000
    end
    respond_to do |format|
      if @textbook.save
        format.html { redirect_to @textbook, notice: 'Textbook was successfully created.' }
        format.json { render :show, status: :created, location: @textbook }
      else
        format.html { render :new }
        format.json { render json: @textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /textbooks/1
  # PATCH/PUT /textbooks/1.json
  def update
 
    respond_to do |format|
      if @textbook.update(textbook_params)
          if @textbook.price >= 10000
            @textbook.update(price: 10000)
          end
        format.html { redirect_to @textbook, notice: 'Textbook was successfully updated.' }
        format.json { render :show, status: :ok, location: @textbook }
      else
        format.html { render :edit }
        format.json { render json: @textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /textbooks/1
  # DELETE /textbooks/1.json
  def destroy
    #Check if the user owns this
    wrong_user_check
    @textbook.destroy
    respond_to do |format|
      format.html { redirect_to textbooks_url, notice: 'Textbook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_textbook
      @textbook = Textbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def textbook_params
      params.require(:textbook).permit(:title, :amazon, :condition, :edition, :section, :isbn, :email, :category, :price, :author, :description, :amount_used, :image, :rentable)
    end

    #Checks user ownership and displays an error if you don't
    def wrong_user_check
      if @textbook.user != current_user
        respond_to do |format|
          format.html{redirect_to pages_error_path, notice: "This isn\'t your listing!"}
          format.json { head :no_content }
        end
      end
    end
  end
