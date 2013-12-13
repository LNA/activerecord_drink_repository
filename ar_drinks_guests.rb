module AR
	class DrinksGuests < ActiveRecord::Base
		belongs_to :drinks 
		belongs_to :guests
	end
end