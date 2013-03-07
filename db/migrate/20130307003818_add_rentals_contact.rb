class AddRentalsContact < ActiveRecord::Migration
  def change
    add_column :rentals, :contact, :string
    add_column :rentals, :base_rate_per_night, :integer
    add_column :rentals, :base_rate_per_week, :integer
    add_column :rentals, :base_rate_per_month, :integer
  end
end
