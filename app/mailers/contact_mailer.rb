class ContactMailer < ActionMailer::Base
  def creation_notice(mail_to, params)
    @contact = Contact.find(params[:contact_id])
    mail(from: 'donotreply@surfinglangosta.com', to: 'brian@onomojo.com', subject: "Surfing Langost: New contact")
  end
end