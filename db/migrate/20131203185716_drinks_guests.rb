class DrinksGuests < ActiveRecord::Migration
  def up
  	create_table :drinks_guests do |drinks_guests|
  		drinks_guests.belongs_to :drink 
  		drinks_guests.belongs_to :guest  
  	end
  end

  def down
  	drop_table :drinks_guests
  end
end
