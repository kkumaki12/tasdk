FactoryBot.define do
  factory :user do
    name { 'MyString' }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { 'password' }
  end
end
