class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name, :last_name, :from, :to, :email, :phone, :message
      t.integer :rental_id
    end
  end
end
