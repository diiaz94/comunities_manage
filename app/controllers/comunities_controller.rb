class ComunitiesController < ApplicationController
  before_action :validate_authentication
  before_action :set_comunity, only: [:show, :edit, :update, :destroy]
  before_action :set_location_values, only: [:index, :new,:edit, :update]
  # GET /comunities
  # GET /comunities.json
  def index
    @comunities = Comunity.all
  end

  # GET /comunities/1
  # GET /comunities/1.json
  def show
  end

  # GET /comunities/new
  def new
    @comunity = Comunity.new
  end

  # GET /comunities/1/edit
  def edit
  end

  # POST /comunities
  # POST /comunities.json
  def create
    @comunity = Comunity.new(comunity_params)

    respond_to do |format|
      if @comunity.save
        format.html { redirect_to @comunity, notice: 'Comunity was successfully created.' }
        format.json { render :show, status: :created, location: @comunity }
      else
        format.html { render :new }
        format.json { render json: @comunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comunities/1
  # PATCH/PUT /comunities/1.json
  def update
    respond_to do |format|
      if @comunity.update(comunity_params)
        format.html { redirect_to @comunity, notice: 'Comunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @comunity }
      else
        format.html { render :edit }
        format.json { render json: @comunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comunities/1
  # DELETE /comunities/1.json
  def destroy
    @comunity.destroy
    respond_to do |format|
      format.html { redirect_to comunities_url, notice: 'Comunity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comunity
      @comunity = Comunity.friendly.find(params[:id])
    end
    def set_location_values
      @states = State.all
      @towns = Town.all
      @parishes = Parish.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comunity_params
      params.require(:comunity).permit(:rif, :cod_registro, :nombre, :direccion, :parish_id, :catastro, :sector)
    end
end
