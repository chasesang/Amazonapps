FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    sequence(:email) {|n| "john#{n}@examples.com"}
    password '123'
  end
end
