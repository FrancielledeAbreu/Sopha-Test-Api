FactoryBot.define do
  factory :store do
    name { "Test Store" }
    association :user
  end
end
