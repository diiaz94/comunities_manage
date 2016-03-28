class Family < ActiveRecord::Base
	belongs_to :comunity
	has_many :profiles
 	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	def slug_candidates
   		[
    		[:nombre_casa, :numero_casa],
   		]
	end

	def numero_casa_format
		if self.numero_casa.length >=4	
			self.numero_casa[0,2]+"-"+self.numero_casa[2,4]
		else
			self.numero_casa
		end
	end
	def kids
		k = []
		self.profiles.each do |profile|
			if profile.edad<12
				k.push(profile)	
			end
		end 
		return k	
	end
	def adults
		ad = []
		self.profiles.each do |profile|
			if profile.edad>11
				ad.push(profile)	
			end
		end 
		return ad	
	end
	def ancients
		an = []
		self.profiles.each do |profile|
			if profile.edad>59
				an.push(profile)	
			end
		end 
		return an	
	end	

	def nombreCompleto
		n = self.nombre_casa+"-"+self.numero_casa
		return n.length<17?n:n[0,14]+"..."
	end
end
