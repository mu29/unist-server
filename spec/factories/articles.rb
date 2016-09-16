FactoryGirl.define do
  factory :article do
    user
    title Faker::Book.title
    content Faker::Lorem.paragraph
  end
end
