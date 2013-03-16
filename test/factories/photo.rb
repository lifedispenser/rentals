FactoryGirl.define do
  factory :photo do
    asset File.new(Rails.root + 'test/fixtures/images/rails.png')
    rental
  end
end