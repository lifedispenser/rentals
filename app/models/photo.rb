class Photo < ActiveRecord::Base
  belongs_to :rental
  has_attached_file :asset,
    styles: {
      thumb: '100x100#',
      featured: '310x210#',
      banner: ''
    },
    convert_options: {
      banner: '-resize "1500x500^" -gravity center -crop "1500x500+0+0" +repage -compress JPEG2000 -quality 75',
    }
  
  validates :rental_id, presence: true

  validates_attachment :asset, presence: true,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/png", "image/gif"] },
    size: { in: 0..5000.kilobytes }

  scope :featured, -> { where(featured: true) }
  scope :banner, -> { where(banner: true) }
  
  include Rails.application.routes.url_helpers

  def to_jq_photo
    {
      "thumbnail_url" => asset.url(:thumb),
      "name" => read_attribute(:photo_file_name),
      "size" => read_attribute(:photo_file_size),
      "url" => asset.url(:original),
      "delete_url" => mr_rogers_photo_path(self),
      "delete_type" => "DELETE"
    }
  end
end