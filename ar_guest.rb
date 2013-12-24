module AR
	class Guest < ActiveRecord::Base
		has_many :drinks_guests, class_name: "DrinksGuests"
		def drinks			
			AR::DrinksGuests.where("guest_id = ?", self.id).map do |relationship|
				relationship.drink			
			end
		end
	end
end