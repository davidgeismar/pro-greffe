module Administration
class TagsController < AdministrationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.search_and_paginate(params)
  end

  # Action JSON for the admin for to autocomplete the tags
    def autocomplete
      #query = Tag.sanitize_name(params[:term].to_s)
      @tags = Tag.where("tags.name ILIKE ?", "%#{query}%").limit(10)
      respond_to do |format|
        format.html
        format.json { render :json => @tags.pluck(:name).to_json }
      end
    end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @taggings = @tag.taggings.search_and_paginate(params)
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to administration_tag_path(@tag), notice: 'tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to administration_tag_path(@tag), notice: 'tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to administration_tags_path, notice: 'tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit!
    end
end
end
