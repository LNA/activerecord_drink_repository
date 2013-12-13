class DrinksGuests < ActiveRecord::Migration
  def up
  	create_table :drinks do |drink|
      drink.string     :booze
      drink.string     :glass
      drink.string     :mixer
      drink.string     :name

      drink.timestamp
    end

    add_index :drinks

    create_table :guests do |guest|
      guest.string     :first_name
      guest.string     :last_name

      guest.timestamp
    end
    add_index :guests

    create_table :drinks_guests do |drinks_guests|
      t.belongs_to :drink
      t.belongs_to :guest
      t.interger :quantity
      t.timestamp
    end
  end

  def down
  end
end
