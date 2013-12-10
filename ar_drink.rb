module AR
	class Drink < ActiveRecord::Base
		has_and_belongs_to_many :guests
	end
end