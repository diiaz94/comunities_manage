class ComunitiesController < ApplicationController
  before_action :validate_authentication
  before_action :validate_admin_access, only: [:index, :create]
  before_action :validate_member_access, except: [:index, :create]
  before_action :validate_member_specifyc_access, except: [:index,:my_comunity,:my_comunity_edit]
  before_action :set_comunity, only: [:show, :edit, :update, :destroy]
  before_action :set_location_values, only: [:index, :new,:edit, :update, :my_comunity,:my_comunity_edit]
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
        format.html { redirect_to @comunity, notice: 'Comunidad creada exitosamente.' }
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
      @comunity.slug=nil
      if @comunity.update(comunity_params)
        format.html { redirect_to @comunity, notice: 'Comunidad actualizada exitosamente.' }
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
      format.html { redirect_to comunities_url, notice: 'Comunidad eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  def my_comunity
    @comunity = current_user.profile.member ? current_user.profile.member.comunity : nil
    if @comunity
       render 'show'
    else 
       redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion.")
    end
  end

  def my_comunity_edit
    @comunity = current_user.profile.member ? current_user.profile.member.comunity : nil
    if @comunity
      render 'edit'
    else 
       redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion.")
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

    def validate_member_specifyc_access
      @comunity = Comunity.friendly.find(params[:id])
      if  (current_user.type.nombre!="Administrador" or session[:type_user]!="Administrador")
        if (current_user.type.nombre=="Miembro" and session[:type_user]=="Miembro")
          if(@comunity.id!=current_user.profile.member.comunity_id)
            redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion.")
          end
        end
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comunity_params
      params.require(:comunity).permit(:rif, :cod_registro, :nombre, :direccion, :parish_id, :catastro, :sector)
    end
end
