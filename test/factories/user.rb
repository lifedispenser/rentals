FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@surfinglangosta.com" }
    password "flabergasted"
    password_confirmation "flabergasted"
  end
end
