FactoryBot.define do
  factory :answer do
    body { 'Лахтюхова ГГ' }
  end

  factory :invalid_answer, class: Answer do
    body { nil }
  end
end
