class UsuarioSessionsController < ApplicationController
	def new
		if current_user
			redirect_back_or_to(root_path,notice:"Usted ya esta logeado con la cedula " + current_user.cedula)
		else
			@user = User.new
		end	
	end
	def create
		if @user = login(params[:cedula],params[:password])
			puts "CORRECT"
			$months=[
		        "Enero",
		        "Febrero",
		        "Marzo",
		        "Abril",
		        "Mayo",
		        "Junio",
		        "Julio",
		        "Agosto",
		        "Septiembre",
		        "Octubre",
		        "Noviembre",
		        "Diciembre"
		      ]
			session[:type_user] = current_user.type.nombre;
					
		    if current_user.type.nombre=="Administrador" and current_user.profile.family != nil
		    	@confirm = "admin"
				render "confirm_session", layout: "blank"
		    else
			    if current_user.type.nombre=="Miembro"
			    	@confirm = "member"
					render "confirm_session", layout: "blank"
				else
					redirect_back_or_to(root_path,notice:"Inicio de sesion exitoso.")
				end
		    end
		else
			puts "NOCORRECT"
			
			flash.now[:alert] = "Verifique su correo o contraseña!"
			render action: :new
		end
	end
	def destroy
		logout
		redirect_to(login_path,notice: "Ha cerrado sesion correctamente.");
	end
	def culminate_login
		if params[:opcion]=="1"
			session[:type_user] = "Administrador";
		end
		if params[:opcion]=="2"
			session[:type_user] = "Miembro";
		end
		if params[:opcion]=="3"
			session[:type_user] = "SimpleUser";
		end
		puts "**************" + session[:type_user]
		redirect_back_or_to(root_path,notice:"Inicio de sesion exitoso.")
	end
end