class RecommandationsController < ApplicationController
  before_action :set_recommandation, only: [:show, :edit, :update, :destroy]

  # GET /recommandations
  # GET /recommandations.json
  def index
    @recommandations = Recommandation.all
  end

  # GET /recommandations/1
  # GET /recommandations/1.json
  def show
  end

  # GET /recommandations/new
  def new
    @recommandation = Recommandation.new
  end

  # GET /recommandations/1/edit
  def edit
  end


  def public_create
    @recommandation = Recommandation.new(recommandation_params)

    respond_to do |format|
      if @recommandation.save
        format.html { redirect_to @recommandation.greffe, notice: 'Votre commentaire a été pris en compte et sera validé par nos équipes' }
        format.json { render :show, status: :created, location: @recommandation }
      else
        format.html { render :new }
        format.json { render json: @recommandation.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /recommandations
  # POST /recommandations.json
  def create
    @recommandation = Recommandation.new(recommandation_params)

    respond_to do |format|
      if @recommandation.save
        format.html { redirect_to @recommandation, notice: 'Recommandation was successfully created.' }
        format.json { render :show, status: :created, location: @recommandation }
      else
        format.html { render :new }
        format.json { render json: @recommandation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommandations/1
  # PATCH/PUT /recommandations/1.json
  def update
    respond_to do |format|
      if @recommandation.update(recommandation_params)
        format.html { redirect_to @recommandation, notice: 'Recommandation was successfully updated.' }
        format.json { render :show, status: :ok, location: @recommandation }
      else
        format.html { render :edit }
        format.json { render json: @recommandation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommandations/1
  # DELETE /recommandations/1.json
  def destroy
    @recommandation.destroy
    respond_to do |format|
      format.html { redirect_to recommandations_url, notice: 'Recommandation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommandation
      @recommandation = Recommandation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recommandation_params
      params.require(:recommandation).permit(:greffe_id, :email, :author, :rating, :comment, :visible, :admin_check)
    end
end
