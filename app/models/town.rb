class Town < ActiveRecord::Base
	belongs_to :state
	has_many :parishes
 	extend FriendlyId
	friendly_id :nombre, use: :slugged
end
