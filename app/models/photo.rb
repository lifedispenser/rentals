class Photo < ActiveRecord::Base
  belongs_to :rental
  has_attached_file :asset
end