module AR
	class Drink < ActiveRecord::Base
		has_many :drinks_guests
		has_many :guests, :through => :drinks_guests
	end
end