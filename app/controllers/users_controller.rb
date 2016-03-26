class UsersController < ApplicationController
  before_action :validate_authentication, except:[:new, :create]
  before_action :validate_admin_access, except:[:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_types, only: [:index, :new,:edit, :update]  
  before_action :validate_fields, only: [:create, :update]
  # GET /users_url
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @editing = false;
  end

  # GET /users/1/edit
  def edit
    @editing = true;
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    cod_error = 0;
    profileArr = Profile.where(cedula: @user.cedula)
    userArr = User.where(cedula: @user.cedula)
    
    if current_user
      if session[:type_user]=="Administrador"
        if userArr.length==1
          if userArr[0].profile
            cod_error=1
          else
            if profileArr.length==1
              @user=userArr[0]
              @user.profile_id = profileArr[0].id
            end
          end
        else
          if profileArr.length==1
            @user.profile_id = profileArr[0].id
          end
        end
      else
        cod_error=3
      end
    else
      if userArr.length==1
        if userArr[0].profile
            cod_error=1
        else
          if profileArr.length!=1
            cod_error=2
          else
            @user=userArr[0]
            @user.profile_id = profileArr[0].id
          end
        end
      else
        if profileArr.length!=1
          cod_error=2
        else
          @user.type_id = Type.where(nombre: "SimpleUser")[0].id
          @user.profile_id = profileArr[0].id
        end
      end
    end


       

    if cod_error == 0
      if current_user
        respond_to do |format|
          if @user.save
            format.html { redirect_to @user, notice: 'User was successfully created.' }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          if @user.save
            format.html { redirect_to login_path, notice: 'Se ha registrado exitosamente.' }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      if cod_error == 1
        redirect_to(new_user_path,alert: "Ya existe un usuario con esta cedula.")
      else
        if cod_error == 2
          redirect_to(new_user_path,alert: "Lo sentimos, no existe un perfil asociado a la cedula de ingresada. Comuniquese con el director de la comunidad")
        else
          if cod_error == 3
            redirect_to(login_path,alert: "No tienes permisos para acceder a esta seccion.")
          end
        end
      end
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end
    def set_types
      @types = Type.all
    end
    def validate_fields
      cedula = params[:user][:cedula]
      pass = params[:user][:password]
      passC = params[:password_confirmation]
    
      if cedula.strip ==""
        redirect_to(:back,alert: "El campo cedula no puede estar vacio")
      else
        if cedula.strip.length<7 || cedula.strip.length >11
          redirect_to(:back,alert: "Verifique la longitud del campo cedula")
        else  
          if pass.strip ==""
            redirect_to(:back,alert: "El campo password no puede estar vacio")
          else
            if !(/^(?=.*[A-Z]).{1,}$/.match(pass.strip))
              redirect_to(:back,alert: "El formato del password no esta correcto")
            else  
              if passC.strip ==""
                redirect_to(:back,alert: "El campo confirmar password no puede estar vacio")
              else
                if pass !=passC
                  redirect_to(:back,alert: "Los passwords deben coincidir")
                end  
              end  
            end
          end  
        end
      end  
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula, :password, :password_confirmation, :type_id, :profile_id)
    end
end
