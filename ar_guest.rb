module AR
	class Guest < ActiveRecord::Base
		has_many :drinks_guests, class_name: "DrinksGuests"
		# has_many :drinks, through: :drinks_guests, class_name: "DrinksGuests"
		def drinks			
			AR::DrinksGuests.where("guest_id = ?", self.id).map do |relationship|
				relationship.drink			end
			
			# drinks_array = []
			# AR::DrinksGuests.all.each do |relationship|
			# 	if relationship.guest_id == self.id
			# 		drinks_array << relationship.drink 
			# 	end
			# end
			# drinks_array
		end
	end
end
