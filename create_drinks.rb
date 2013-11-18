class CreateDrinks < ActiveRecord::Migration
  def up
    create_table :drinks do |drink|
      drink.string     :booze
      drink.string     :glass
      drink.string     :mixer
      drink.string     :name

      drink.timestamp
    end
    add_index :drinks
  end

  def down
    drop_table :drinks 
  end
end