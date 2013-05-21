class AddPhotoProcessing < ActiveRecord::Migration
  def change
    add_column :photos, :asset_processing, :boolean
  end
end
