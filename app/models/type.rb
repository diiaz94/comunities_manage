class Type < ActiveRecord::Base
	has_many :users
	extend FriendlyId
  	friendly_id :nombre, use: :slugged
end
