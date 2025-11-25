FactoryBot.define do
  factory :note do
    message { "This is a test note" }
    association :project
    association :user
  end
end
