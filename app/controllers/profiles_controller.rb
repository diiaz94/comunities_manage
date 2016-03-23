class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_families, only: [:index, :new,:edit, :update]
  before_action :validate_fields, only: [:create, :update]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
    @my_array = Profile.select(:family_id).group(:family_id)
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @editing = true;
  end

  # POST /profiles
  # POST /profiles.json
  def create

  @profile = Profile.new(profile_params)

  cedula = params[:profile][:cedula]
    if Profile.where(cedula: cedula.strip).length>0
        redirect_to(:back,alert: "Lo sentimos, ya existe un perfil con esta cedula.") 
        return
    end

      respond_to do |format|
        if @profile.save
          format.html { redirect_to @profile, notice: 'El perfil fue creado exitosamente.' }
          format.json { render :show, status: :created, location: @profile }
        else
          format.html { render :new }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
    end

  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'El perfil fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'El perfil fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end
  def set_particles_profiles
    @family= Family.friendly.find(params[:id])
    @profiles = Profile.where(family_id: @family.id)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.friendly.find(params[:id])
    end
    def set_families

      if session[:type_user]=="Administrador"
       @families = Family.all.pluck(:nombre_casa,:id);
       y=Family.all.pluck(:numero_casa);
      end
      if session[:type_user]=="Miembro"
       @families = Family.where(comunity_id: current_user.profile.member.comunity.id).pluck(:nombre_casa,:id);
       y=Family.where(comunity_id: current_user.profile.member.comunity.id).pluck(:numero_casa);
      end
      if session[:type_user]=="SimpleUser"
       @families = Family.where(comunity_id: current_user.profile.family.comunity.id).pluck(:nombre_casa,:id);
       y=Family.where(comunity_id: current_user.profile.family.comunity.id).pluck(:numero_casa);
      end
      for i in 0..@families.length-1
        @families[i][0]=@families[i][0]+" - Nro "+y[i].to_s
      end
    end
    def validate_fields
      avatar = params[:profile][:photo]
      cedula = params[:profile][:cedula]
      pnombre = params[:profile][:primer_nombre]
      papellido = params[:profile][:primer_apellido]
      email = params[:profile][:email]
      telefono = params[:profile][:telefono]
      fecha_nac =[ 
                  params[:profile]["fecha_nac(3i)"],
                  params[:profile]["fecha_nac(2i)"],
                  params[:profile]["fecha_nac(1i)"],
                ]
      fecha_ing =[ 
            params[:profile]["fecha_ing(3i)"],
            params[:profile]["fecha_ing(2i)"],
            params[:profile]["fecha_ing(1i)"],
          ]          
      if avatar!=nil
        if avatar.size>50000
          redirect_to(:back,alert: "Lo sentimos, la imagen es demasiado grande. Recuerde que la imagen debe pesar menos de 50KB y el formato debe ser JPG.") 
          return
        else
          if avatar.original_filename.split('.').last.downcase != "jpg"
            redirect_to(:back,alert: "Lo sentimos, la imagen no es formato jpg. Recuerde que la imagen debe pesar menos de 10KB y el formato debe ser JPG.")
            return
          end
        end
      end  
      
      if session[:type_user] != "SimpleUser" and cedula.strip == ""
          redirect_to(:back,alert: "Lo sentimos, la cedula no puede estar en blanco.")
          return
      else    
        if pnombre.strip == ""
          redirect_to(:back,alert: "Lo sentimos, el primer nombre no puede estar en blanco.")
          return
        else 
          if papellido.strip == ""
            redirect_to(:back,alert: "Lo sentimos, el primer apellido no puede estar en blanco.")
            return
          else
            if email.strip == ""
              redirect_to(:back,alert: "Lo sentimos, el email no puede estar en blanco.")
              return
            else
              if telefono.strip == ""
                redirect_to(:back,alert: "Lo sentimos, el telefono no puede estar en blanco.")
                return
              else
                if telefono.strip.length!=11
                  redirect_to(:back,alert: "Lo sentimos, debe ingresar un numero de celular valido (04121234567).")
                  return
                else
                  if fecha_nac[0] == "" or fecha_nac[1] == "" or fecha_nac[2] == "" 
                    redirect_to(:back,alert: "Lo sentimos, debe elegir un fecha de nacimiento valida.")
                    return
                  else
                    if session[:type_user] != "SimpleUser" and (fecha_ing[0] == "" or fecha_ing[1] == "" or fecha_ing[2] == "") 
                      redirect_to(:back,alert: "Lo sentimos, debe elegir una fecha de ingreso valida.")
                      return
                    end
                  end
                end
              end                   
            end                 
          end 
        end
      end   



    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:cedula, :primer_nombre,:segundo_nombre, :primer_apellido, :segundo_apellido, :email, :telefono, :fecha_nac,:fecha_ing, :family_id,:photo)
    end
end
