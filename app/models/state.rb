class State < ActiveRecord::Base
	has_many :towns
	extend FriendlyId
	friendly_id :nombre, use: :slugged
end
