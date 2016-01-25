class Member < ActiveRecord::Base
	belongs_to :comunity
	belongs_to :profile
	belongs_to :job
	extend FriendlyId
	friendly_id :cargo, use: :slugged

	def cargo
		self.job.nombre	
	end	
end
