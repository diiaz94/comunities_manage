class WelcomeController < ApplicationController
	before_action :validate_fields_profile, only: [:create_admin_profile]
	before_action :validate_fields_user, only: [:create_admin_user]
  def index

  	if User.all.length > 0
  		@notUsers = false;
  	else
  		@notUsers = true;
  		puts "not User************"
  		redirect_to admin_profile_path

  	end

  end

  def admin_profile
  	if(Profile.all.length>0)
  		redirect_to admin_user_path
  	else
	  	@profile = Profile.new
	  	render "register_profile", layout: "blank"
  	end
	
  end
  
  def create_admin_profile
  	@profile = Profile.new(profile_params)
  	@profile.save
  	redirect_to admin_user_path
  end

  def admin_user
  	@user = User.new
    @profile = Profile.last
    if @profile!=nil
      puts "EPAAAA***************"
      render "register_user", layout: "blank"
    else
      redirect_to admin_profile_path
    end
  end

  def create_admin_user
  	@user = User.new(user_params)

  	if(Profile.all.length>0)
      puts "PROFILEE" + @profile.to_s
  		@user.profile = Profile.last
      @user.cedula = @user.profile.cedula

      types=Type.where(nombre: "Administrador")
      if types.length>0
    		@user.type_id =  types[0].id
    		if @user.save
    	 	 redirect_to login_path
        else
         redirect_to(:back,alert: "Lo sentimos, no se ha podido crear el usuario Administrador.")
         return
        end
      else
        redirect_to(:back,alert: "Lo sentimos, no se ha podido crear el usuario Administrador.")
        return
      end
  	else
		  redirect_to(:back,alert: "Lo sentimos, no existe un perfil con esa cedula.")
    	return
  	end


  end


	private


	def validate_fields_profile
      #avatar = params[:profile][:photo]
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
      #if avatar!=nil
      #  if avatar.size>50000
       #   redirect_to(:back,alert: "Lo sentimos, la imagen es demasiado grande. Recuerde que la imagen debe pesar menos de 50KB y el formato debe ser JPG.") 
        #  return
        #else
         # if avatar.original_filename.split('.').last.downcase != "jpg"
          #  redirect_to(:back,alert: "Lo sentimos, la imagen no es formato jpg. Recuerde que la imagen debe pesar menos de 10KB y el formato debe ser JPG.")
           # return
          #end
        #end
      #end  
      
      if cedula.strip == ""
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
                if fecha_nac[0] == "" or fecha_nac[1] == "" or fecha_nac[2] == "" 
                  redirect_to(:back,alert: "Lo sentimos, debe elegir un fecha de nacimiento valida.")
                  return
                else
                  if (fecha_ing[0] == "" or fecha_ing[1] == "" or fecha_ing[2] == "") 
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


    def validate_fields_user
      pass = params[:user][:password]
      passC = params[:password_confirmation]
  
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

    def user_params
      params.require(:user).permit(:cedula, :password, :password_confirmation)
    end
    def profile_params
      params.require(:profile).permit(:cedula, :primer_nombre,:segundo_nombre, :primer_apellido, :segundo_apellido, :email, :telefono, :fecha_nac,:fecha_ing, :family_id,:photo)
    end
end
