class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

	def validate_authentication
		if !current_user
	        redirect_to(login_path,alert: "Debes iniciar sesion para acceder a esta seccion")
	    end
	end
	def validate_admin_access
        if current_user.type.nombre!="Administrador"
          redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion")
        end
    end
	def validate_member_access
        if current_user.type.nombre!="Administrador"
        	if current_user.type.nombre!="Miembro"
          		redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion")
        	end
        end
    end

end
