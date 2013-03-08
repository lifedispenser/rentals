class AddPhotosChecksum < ActiveRecord::Migration
  def change
    add_column :photos, :asset_fingerprint, :string
  end
end
