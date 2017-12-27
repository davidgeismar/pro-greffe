module Administration
  class GreffesController < AdministrationController
    before_action :set_greffe, only: [:show, :edit, :update, :destroy]

    # GET /articles
    # GET /articles.json
    def index
      @greffes = Greffe.search_and_paginate(params)
    end

    # GET /articles/1
    # GET /articles/1.json
    def show
    end

    # GET /articles/new
    def new
      @greffe = Greffe.new
    end

    # GET /articles/1/edit
    def edit
    end

    # POST /articles
    # POST /articles.json
    def create
      @greffe = Greffe.new(article_params)

      respond_to do |format|
        if @greffe.save
          format.html { redirect_to administration_article_path(@greffe), notice: 'Greffe was successfully created.' }
          format.json { render :show, status: :created, location: @greffe }
        else
          format.html { render :new }
          format.json { render json: @greffe.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /articles/1
    # PATCH/PUT /articles/1.json
    def update
      respond_to do |format|
        if @greffe.update(greffe_params)
          format.html { redirect_to administration_greffe_path(@greffe), notice: 'Greffe was successfully updated.' }
          format.json { render :show, status: :ok, location: @greffe }
        else
          format.html { render :edit }
          format.json { render json: @greffe.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /articles/1
    # DELETE /articles/1.json
    def destroy
      @greffe.destroy
      respond_to do |format|
        format.html { redirect_to administration_articles_path, notice: 'Greffe was successfully destroyed.' }
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
end
