FactoryBot.define do
  factory :question do
    title { 'Что это?' }
    body { 'Что это за мразь?' }
  end

  factory :invalid_question, class: Question do
    title { nil }
    body { nil }
  end
end
