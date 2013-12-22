module AR
	class Drink < ActiveRecord::Base
		has_many :drinks_guests, class_name: "DrinksGuests"
		has_many :guests, through: :drinks_guests, class_name: "DrinksGuests"
	end
end
