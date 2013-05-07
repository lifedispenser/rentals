FactoryGirl.define do
  factory :contact do
    first_name 'John'
    last_name 'Smith'
    email 'test@test.com'
    phone '123-456-7890'
    from '10/10/2015'
    to '10/10/2014'
    message 'This is great'
  end
end