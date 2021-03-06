class FamiliesController < ApplicationController
  before_action :validate_authentication
  before_action :validate_member_access, only: [:update,:destroy,:create]
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  before_action :set_comunities, only: [:index, :new,:edit, :update]
  before_action :validate_fields, only: [:create, :update]
  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/1
  # GET /families/1.json
  def show
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
     @editing = true;
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)
    if session[:type_user]=="Miembro"
      @family.comunity = current_user.profile.member.comunity
    end  
    respond_to do |format|
      if @family.save
        format.html { redirect_to @family, notice: 'La familia fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @family }
      else
        format.html { render :new }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    respond_to do |format|
      @family.slug=nil
      if @family.update(family_params)
        format.html { redirect_to @family, notice: 'La familia fue actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @family }
      else
        format.html { render :edit }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url, notice: 'La familia fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.friendly.find(params[:id])
    end
    def set_comunities
      @comunities = Comunity.all
    end

    def validate_fields
      nombre = params[:family][:nombre_casa]
      numero = params[:family][:numero_casa] 
      if nombre.strip ==""
          redirect_to(:back,alert: "Lo sentimos, el nombre no puede estar en blanco.")
          return
      else
        if numero.strip == ""
          redirect_to(:back,alert: "Lo sentimos, el numero no puede estar en blanco.")
          return
        else
          if Family.where(numero_casa:numero).count>0 || Family.where(nombre_casa: nombre,numero_casa:numero).count>0 
          redirect_to(:back,alert: "Lo sentimos, ya existe un familia con estos datos.")
          return
          end  
        end  
      end     
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def family_params
      params.require(:family).permit(:nombre_casa, :numero_casa, :telefono, :comunity_id,:direccion)
    end
end
