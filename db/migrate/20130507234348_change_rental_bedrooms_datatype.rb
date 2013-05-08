class ChangeRentalBedroomsDatatype < ActiveRecord::Migration
  def up
    change_column :rentals, :bedrooms, :integer
    change_column :rentals, :bathrooms, :integer
  end
  
  def down
    change_column :rentals, :bedrooms, :decimal, precision: 3, scale: 1
    change_column :rentals, :bathrooms, :decimal, precision: 3, scale: 1
  end
end
