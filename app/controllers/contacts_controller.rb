class ContactsController < ApplicationController
  def create
    @contact = Contact.create(post_params)
    flashy(@contact)
    redirect_to :back
  end
  
  private
    def post_params
       params.require(:contact).permit(:first_name, :last_name, :from, :to, :message)
    end
end
