class Li < ApplicationRecord

	has_many :tels
	accepts_nested_attributes_for :tels, allow_destroy: true
	
end
