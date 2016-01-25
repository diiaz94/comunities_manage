class TypeRequest < ActiveRecord::Base
	has_many :requests
	extend FriendlyId
	friendly_id :nombre, use: :slugged

end
