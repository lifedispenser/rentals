class AddPhotosFeatured < ActiveRecord::Migration
  def change
    add_column :photos, :banner, :boolean, default: false
    add_column :photos, :featured, :boolean, default: false
    add_index :photos, :banner
    add_index :photos, :featured
  end
end
