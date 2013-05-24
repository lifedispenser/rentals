class Rental < ActiveRecord::Base
  validates :name, presence: true, :length => { :in => 2..255 }
  validates :description, presence: true, :length => { :in => 50..255 }
  validates :contact, presence: true, :length => { :in => 5..255 }
  
  has_many :photos, :dependent => :destroy

  scope :featured, -> { includes(:photos).where('photos.featured is true').references(:photos) }
  scope :banner, -> { includes(:photos).where('photos.banner is true').references(:photos) }
  scope :pet_friendly, -> { where(pet_friendly: true) }
  scope :kid_friendly, -> { where(kid_friendly: true) }
  scope :long_term, -> { where(long_term: true) }
  scope :published, -> { where(published: true) }

  def featured_photo
    if photos.empty?
      ''
    elsif photos.featured.empty?
      photos.first
    else
      photos.featured.first
    end
  end
  
  def banner_photo
    if photos.empty?
      ''
    elsif photos.banner.empty?
      photos.first
    else
      photos.banner.first
    end
  end
  
  def publish!
    update_attribute(:published, true) if photos.count > 0
  end

  def unpublish!
    update_attribute(:published, false)
  end
end
