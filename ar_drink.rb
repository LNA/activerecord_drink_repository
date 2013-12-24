module AR
	class Drink < ActiveRecord::Base
		has_many :orders, class_name: "Orders"
		has_many :guests, through: :orders, class_name: "Orders"
	end
end
