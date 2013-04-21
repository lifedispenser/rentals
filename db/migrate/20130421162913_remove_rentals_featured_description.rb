class RemoveRentalsFeaturedDescription < ActiveRecord::Migration
  def change
    remove_column :rentals, :description, :text
    rename_column :rentals, :featured_description, :description
  end
end
