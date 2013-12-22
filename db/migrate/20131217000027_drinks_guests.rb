class DrinksGuests < ActiveRecord::Migration
  def up
  	create_table :drinks_guests do |drinks_guests|
      drinks_guests.belongs_to :drink
      drinks_guests.belongs_to :guest
      drinks_guests.integer :quantity
      drinks_guests.timestamp
    end
    add_index :drinks_guests, :guest_id 
  end

  def down
  	drop_table :drinks_guests
  end
end
