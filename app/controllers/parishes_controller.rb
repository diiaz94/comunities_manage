class ParishesController < ApplicationController
  before_action :validate_authentication
  before_action :validate_admin_access  
  before_action :set_parish, only: [:show, :edit, :update, :destroy]
  before_action :set_towns, only: [:index, :new,:edit, :update]
  # GET /parishes
  # GET /parishes.json
  def index
    @parishes = Parish.all
  end

  # GET /parishes/1
  # GET /parishes/1.json
  def show
  end

  # GET /parishes/new
  def new
    @parish = Parish.new
  end

  # GET /parishes/1/edit
  def edit
  end

  # POST /parishes
  # POST /parishes.json
  def create
    @parish = Parish.new(parish_params)

    respond_to do |format|
      if @parish.save
        format.html { redirect_to @parish, notice: 'Parish was successfully created.' }
        format.json { render :show, status: :created, location: @parish }
      else
        format.html { render :new }
        format.json { render json: @parish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parishes/1
  # PATCH/PUT /parishes/1.json
  def update
    respond_to do |format|
      if @parish.update(parish_params)
        format.html { redirect_to @parish, notice: 'Parish was successfully updated.' }
        format.json { render :show, status: :ok, location: @parish }
      else
        format.html { render :edit }
        format.json { render json: @parish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parishes/1
  # DELETE /parishes/1.json
  def destroy
    @parish.destroy
    respond_to do |format|
      format.html { redirect_to parishes_url, notice: 'Parish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parish
      @parish = Parish.friendly.find(params[:id])
    end
    def set_towns
      @towns = Town.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def parish_params
      params.require(:parish).permit(:nombre,:town_id)
    end
end
