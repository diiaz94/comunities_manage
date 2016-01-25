class Job < ActiveRecord::Base
	has_many :members
	extend FriendlyId
	friendly_id :nombre, use: :slugged	
end
