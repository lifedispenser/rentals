class Rental < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :contact, presence: true
  
  has_many :photos, :dependent => :destroy

  scope :featured, -> { includes(:photos).where('photos.featured is true').references(:photos) }

  def featured_photo
    if photos.empty?
      ''
    elsif photos.featured.empty?
      photos.first
    else
      photos.featured.first
    end
  end
end
