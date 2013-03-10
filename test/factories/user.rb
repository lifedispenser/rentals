FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@surfinglangosta.com" }
    password "testtest"
    password_confirmation "testtest"
  end
end
