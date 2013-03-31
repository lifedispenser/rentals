class AddRentalsFeaturedDescription < ActiveRecord::Migration
  def change
    add_column :rentals, :featured_description, :string
  end
end
