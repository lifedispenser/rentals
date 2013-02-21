class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.string :name
      t.text :description
      t.decimal :bedrooms, precision: 3, scale: 1
      t.decimal :bathrooms, precision: 3, scale: 1
      t.boolean :pet_friendly, default: false
      t.boolean :kid_friendly, default: false
      t.integer :rate_per_night
      t.integer :rate_per_week
      t.integer :rate_per_month
      t.timestamps
    end
  end
end
