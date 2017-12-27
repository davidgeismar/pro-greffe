class DepartmentsController < ApplicationController
  before_action :authenticate_administrator_user, only:[:edit, :update, :destroy, :create, :new]
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.order(:department_number).all
    @locations = []
    Greffe.where.not(latitude: nil).pluck(:latitude, :longitude, :name, :description, :slug).each do |l|
      @locations.push([{lat: l[0], lng: l[1]}, {name: l[2], description: l[3], slug: l[4]}])
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    # @greffe = @department.greffe.search_and_paginate(params)
    @greffes = @department.greffes.paginate(page: nil, per_page: 48)
    @cities = @department.cities_uniq.search_and_paginate(params) #{page: params, per_page: 99}
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :description, :small_image, :department_number, :external_url, :slug)
    end
end
