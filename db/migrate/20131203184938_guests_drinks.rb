class GuestsDrinks < ActiveRecord::Migration
  def up
  	create_table :guests_drinks do |guests_drinks|
  		guests_drinks.belongs_to :drink 
  		guests_drinks.belongs_to :guest 
  	end
  end

  def down
  	drop_table :guests_drinks
  end
end
