require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }

  it 'the answer has one question' do
    q = FactoryBot.build(:question)
    a = FactoryBot.build(:answer)
    a.question = q
    expect(a.question).to eq(q)
  end 
end
