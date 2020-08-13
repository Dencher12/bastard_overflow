FactoryBot.define do
  factory :authhorization do
    user { nil }
    provider { "MyString" }
    uid { "MyString" }
  end
end
