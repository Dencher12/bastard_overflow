require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it 'the question has many answers' do
    q = FactoryBot.build(:question)
    a = FactoryBot.build(:answer)
    q.answers << a
    expect(q.answers).to eq([a])
  end
end
