module AR
	class Guest < ActiveRecord::Base
		has_many :drinks_guests
		has_many :drinks, :through => :drinks_guests
	end
end