class Request < ActiveRecord::Base
	require 'erb'
	belongs_to :type_request
	belongs_to :status_request
	belongs_to :profile
	belongs_to :comunity
	extend FriendlyId
	friendly_id :identifier, use: :slugged
	def identifier
		self.type_request.nombre+self.profile.cedula 
	end	
end
