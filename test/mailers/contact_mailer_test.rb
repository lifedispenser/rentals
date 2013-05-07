require 'test_helper'
 
describe ContactMailer do
  describe '#creation_notice' do
    before(:each) do
      @contact = FactoryGirl.create(:contact)
      @mail = ContactMailer.creation_notice(nil, {contact_id: @contact.id})
    end
    
    #ensure that the subject is correct
    it 'renders the subject' do
      assert_equal "Surfing Langost: New contact", @mail.subject
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      assert_equal ['brian@onomojo.com'], @mail.to
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      assert_equal ['donotreply@surfinglangosta.com'], @mail.from
    end
    
    it 'adds contact attributes to message' do
      assert @mail.body.encoded.include?(@contact.first_name)
      assert @mail.body.encoded.include?(@contact.last_name)
      assert @mail.body.encoded.include?(@contact.phone)
      assert @mail.body.encoded.include?(@contact.email)
      assert @mail.body.encoded.include?(@contact.from)
      assert @mail.body.encoded.include?(@contact.to)
      assert @mail.body.encoded.include?(@contact.message)
    end
  end
end