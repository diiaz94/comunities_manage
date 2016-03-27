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
        if current_user.type.nombre!="Administrador"||session[:type_user]!="Administrador"
          redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion")
        end
    end
	def validate_member_access
        if current_user.type.nombre!="Administrador"||session[:type_user]!="Administrador"
        	if current_user.type.nombre!="Miembro"||session[:type_user]!="Miembro"
          		redirect_to(root_path,alert: "Lo sentimos, no tiene permisos para acceder esta seccion")
        	end
        end
    end


require "rubygems"
require "net/https"
require "uri"
require "json"

def getCurrentTime

  uri = URI.parse("http://api.timezonedb.com/?zone=America/Caracas&format=json&key=ZKLS5YG2UNIH")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)

  res = http.request(request)
  response = JSON.parse(res.body)
  if(response["timestamp"])
    DateTime.strptime(response["timestamp"].to_s,'%s').to_formatted_s(:db) 
  else
    DateTime.current.to_formatted_s(:db) 
  end
 end  
helper_method :getCurrentTime


end
