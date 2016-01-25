class Parish < ActiveRecord::Base
	belongs_to :town
	has_many :comunities
 	extend FriendlyId
	friendly_id :nombre, use: :slugged
end
