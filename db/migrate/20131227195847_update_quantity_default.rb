class UpdateQuantityDefault < ActiveRecord::Migration
  def up
  	change_column_default(:orders, :quantity, 0)
  end
end
