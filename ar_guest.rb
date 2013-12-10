module AR
	class Guest < ActiveRecord::Base
		has_and_belongs_to_many :drinks
	end
end