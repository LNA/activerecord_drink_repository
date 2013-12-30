module AR
	class Guest < ActiveRecord::Base
		has_many :orders, class_name: "Orders"
		def drinks			
			AR::Orders.where("guest_id = ?", self.id).map do |relationship|
				relationship.drink			
			end
		end
	end
end