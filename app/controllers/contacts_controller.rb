class ContactsController < ApplicationController
  def create
    @contact = Contact.new(post_params)
    if @contact.save
      flash[:success] = 'Thanks for your inquiry. One of our agents will be contacting you shortly.'
    else
      flash[:error] = 'Your email address is required.'
    end
    redirect_to :back
  end
  
  private
    def post_params
       params.require(:contact).permit(:first_name, :last_name, :email, :phone, :from, :to, :message, :rental_id)
    end
end
