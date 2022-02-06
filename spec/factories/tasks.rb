FactoryBot.define do
  factory :task do
    name { 'MyString' }
    content { 'MyText' }
    expiration_deadline { Time.zone.now }
  end
end
