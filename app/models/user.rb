class User < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :type
  belongs_to :profile
  extend FriendlyId
  friendly_id :cedula, use: :slugged
end

