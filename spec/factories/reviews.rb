FactoryGirl.define do
  factory :review do

    association :user, factory: :user
    association :product, factory: :product

    rating { rand(1..5)}
    body   { Faker::Hipster.paragraph }

  end
end
