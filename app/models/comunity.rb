class Comunity < ActiveRecord::Base
	has_many :families
	has_many :members
	has_many :requests
	belongs_to :parish
	extend FriendlyId
	friendly_id :nombre, use: :slugged	

	def rif_format
		c = self.rif
		c.length>2?"J-"+c[0,c.length-2]+"-"+c[c.length-1,c.length]: c
	end
	def cod_registro_format
		c = self.cod_registro
		c.length==13?c[0,2]+"-"+c[2,2]+"-"+c[4,2]+"-"+c[6,3]+"-"+c[9,4]: c
	end

	def catastro_format
		c = self.catastro.to_s

		c.length==4?c[0,2]+"-"+c[2,c.length]: c
	end
end
