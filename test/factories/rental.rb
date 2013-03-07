FactoryGirl.define do
  factory :rental do
    name Faker::Lorem.words(3).to_s
    description Faker::Lorem.sentences(3).to_s
    contact Faker::Lorem.sentences(3).to_s
  end
end
