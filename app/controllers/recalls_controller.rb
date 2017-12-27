class RecallsController < ApplicationController
  before_action :set_recall, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_administrator_user,  only:[:index, :show, :destroy, :edit]

  # GET /recalls
  # GET /recalls.json
  def index
    @recalls = Recall.all
  end

  # GET /recalls/1
  # GET /recalls/1.json
  def show
  end

  # GET /recalls/new
  def new
    @recall = Recall.new
    @page_origin = params[:page_origin] || "Non définie"
  end

  def create
    @recall = Recall.new(recall_params)
    respond_to do |format|
      if @recall.save
        format.html { redirect_to @recall, notice: 'Recall was successfully created.' }
        format.json { render :show, status: :created, location: @recall }
        format.js
      else
        @message = "Une erreur est survenue"
        format.html { render :new }
        format.json { render json: @recall.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /recalls/1/edit
  def edit
  end


  # PATCH/PUT /recalls/1
  # PATCH/PUT /recalls/1.json
  def update
    respond_to do |format|
      if @recall.update(recall_params)
        format.html { redirect_to @recall, notice: 'Recall was successfully updated.' }
        format.json { render :show, status: :ok, location: @recall }
      else
        format.html { render :edit }
        format.json { render json: @recall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recalls/1
  # DELETE /recalls/1.json
  def destroy
    @recall.destroy
    respond_to do |format|
      format.html { redirect_to recalls_url, notice: 'Recall was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book_a_meeting_static
    @recall = Recall.new
    @page_origin = params[:page_origin] || "Non définie"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recall
      @recall = Recall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recall_params
      params.require(:recall).permit(:phone, :recall_date, :recall_now, :reason, :origin, :reason)
    end
end
