class AddRentalPublished < ActiveRecord::Migration
  def change
    add_column :rentals, :published, :boolean, default: false
    add_index :rentals, :published
  end
end
