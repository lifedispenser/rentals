class Contact < ActiveRecord::Base
  validates :email, presence: true, :length => { :in => 2..255 }
  has_one :rental
  
  after_create :send_mail
  
  def send_mail
    ContactMailer.creation_notice(nil, contact_id: id).deliver
  end
end