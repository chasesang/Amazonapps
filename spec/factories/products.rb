FactoryGirl.define do
  factory :product do
    association :user, factory: :user


    sequence(:title) {|n| "#{Faker::Commerce.product_name} #{n}"  }
    price { rand(1..100)}
    description { Faker::Hipster.paragraph }

  end
end
