class AddRentalsLongTerm < ActiveRecord::Migration
  def change
    add_column :rentals, :long_term, :boolean, default: false
    add_index :rentals, :long_term
  end
end
