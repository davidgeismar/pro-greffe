class GreffesController < ApplicationController
  before_action :authenticate_administrator_user,  only:[:edit, :update, :destroy, :create, :new]
  before_action :set_greffe, only: [:show, :edit, :update, :destroy]


  # GET /greffes
  # GET /greffes.json
  def index
    @greffes = Greffe.search_and_paginate(params)
  end

  # GET /greffes/1
  # GET /greffes/1.json
  def show
    @department = @greffe.department
    @near_greffes = @greffe.near_greffes.search_and_paginate(params)
    # @near_greffes_from_greffe = @greffe.near_greffes_from_greffe.search_and_paginate(params)
    # @near_greffes_other_greffe = @greffe.near_greffes_other_greffe.search_and_paginate(params)
    @recommandations = @greffe.recommandations.search_and_paginate(params)
  end

  # GET /greffes/new
  def new
    @greffe = Greffe.new
  end

  # GET /greffes/1/edit
  def edit
  end

  # POST /greffes
  # POST /greffes.json
  def create
    @greffe = Greffe.new(greffe_params)

    respond_to do |format|
      if @greffe.save
        format.html { redirect_to @greffe, notice: 'Greffe was successfully created.' }
        format.json { render :show, status: :created, location: @greffe }
      else
        format.html { render :new }
        format.json { render json: @greffe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /greffes/1
  # PATCH/PUT /greffes/1.json
  def update
    respond_to do |format|
      if @greffe.update(greffe_params)
        format.html { redirect_to @greffe, notice: 'Greffe was successfully updated.' }
        format.json { render :show, status: :ok, location: @greffe }
      else
        format.html { render :edit }
        format.json { render json: @greffe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /greffes/1
  # DELETE /greffes/1.json
  def destroy
    @greffe.destroy
    respond_to do |format|
      format.html { redirect_to greffes_url, notice: 'Greffe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_greffe
      @greffe = Greffe.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def greffe_params
      params.require(:greffe).permit(:id,
                                      :number,
                                      :name,
                                      :scrap_coordinates,
                                      :latitude,
                                      :longitude,
                                      :scrap_address,
                                      :address,
                                      :zip_code,
                                      :phone,
                                      :fax,
                                      :website_url,
                                      :schedule,
                                      :clerks,
                                      :tribunal_type,
                                      :monday_hours,
                                      :tuesday_hours,
                                      :thursday_hours,
                                      :friday_hours,
                                      :saturday_hours,
                                      :sunday_hours,
                                      :slug,
                                      :priority_order,
                                      :scrap_data,
                                      :description,
                                      :department_id,
                                      :city_id
                                    )
    end
end
