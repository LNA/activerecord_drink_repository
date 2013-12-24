module AR
	class Orders < ActiveRecord::Base
		belongs_to :drink, class_name: "Drink"
		belongs_to :guest, class_name: "Guest"
	end
end
