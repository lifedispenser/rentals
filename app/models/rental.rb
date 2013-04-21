class Rental < ActiveRecord::Base
  validates :name, presence: true, :length => { :in => 2..255 }
  validates :description, presence: true, :length => { :in => 50..255 }
  validates :contact, presence: true, :length => { :in => 5..255 }
  
  has_many :photos, :dependent => :destroy

  scope :featured, -> { includes(:photos).where('photos.featured is true').references(:photos).order('RANDOM()') }

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
