FactoryGirl.define do
  factory :photo do
    asset File.new(Rails.root + 'test/assets/images/rails.png')
  end
end