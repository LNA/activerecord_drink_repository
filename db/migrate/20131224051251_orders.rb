class Orders < ActiveRecord::Migration
  def up
  	create_table :orders do |orders|
      orders.belongs_to :drink
      orders.belongs_to :guest
      orders.integer :quantity
      orders.timestamp
    end
    add_index :orders, :guest_id 
  end

  def down
  	drop_table :orders
  end
end