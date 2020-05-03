require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user)}

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it {should_not be_able_to :manage, :all}
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }
    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:user2) { create :user }

    let(:question) { create :question, user: user }
    let(:answer) { create :answer, user: user, question: question }

    let(:question2) { create :question, user: user2 }
    let(:answer2) { create :answer, user: user2, question: question2 }
    
    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }  
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, question, user: user}
    it { should_not be_able_to :update, question2, user: user}

    it { should be_able_to :update, answer, user: user}
    it { should_not be_able_to :update, answer2, user: user}

    it { should be_able_to :destroy, question, user: user}
    it { should_not be_able_to :destroy, question2, user: user}

    it { should be_able_to :destroy, answer, user: user}
    it { should_not be_able_to :destroy, answer2, user: user}
  end
end
