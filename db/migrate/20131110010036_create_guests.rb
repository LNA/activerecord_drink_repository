class CreateGuests < ActiveRecord::Migration
  def up
    create_table :guests do |guest|
      guest.string     :first_name
      guest.string     :last_name

      guest.timestamp
    end
    add_index :guests
  end

  def down
    drop_table :guests 
  end
end