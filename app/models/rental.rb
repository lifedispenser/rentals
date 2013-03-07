class Rental < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :contact, presence: true
  
  has_many :photos
end
