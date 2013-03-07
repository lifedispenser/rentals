class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :rental
    end
    add_attachment :photos, :asset
  end
end
