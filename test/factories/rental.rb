FactoryGirl.define do
  factory :rental do
    name Faker::Lorem.words(3).join(' ').to_s[0..255]
    description Faker::Lorem.sentences(5).join(' ').to_s[0..255]
    contact Faker::Lorem.sentences(3).join(' ').to_s[0..255]
    published true
    
    factory :rental_with_photos do
      ignore do
        photo_count 5
      end
      
      after(:create) do |rental, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photo_count, rental: rental)
      end

      factory :featured_rental do
        after(:create) do |rental, evaluator|
          FactoryGirl.create_list(:photo, evaluator.photo_count, rental: rental, featured: true)
        end
      end

      factory :banner_rental do
        after(:create) do |rental, evaluator|
          FactoryGirl.create_list(:photo, evaluator.photo_count, rental: rental, banner: true)
        end
      end

    end
  end
end
