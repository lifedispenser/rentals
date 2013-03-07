class AddRentalsIndexes < ActiveRecord::Migration
  def change
    add_index :rentals, :pet_friendly
    add_index :rentals, :kid_friendly
    add_index :rentals, :rate_per_night
    add_index :rentals, :rate_per_week
    add_index :rentals, :rate_per_month
    add_index :rentals, :bathrooms
    add_index :rentals, :bedrooms
  end
end
