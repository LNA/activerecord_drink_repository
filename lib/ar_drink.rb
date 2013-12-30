module AR
	class Drink < ActiveRecord::Base
		has_many :orders, class_name: "Orders"
		def guests			
			AR::Orders.where("drink_id = ?", self.id).map do |relationship|
				relationship.guest		
			end
		end
	end
end
