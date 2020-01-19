require 'rails_helper'

feature 'Delete question' do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { build(:question) }

  before do
    question.user = user
    question.save
  end

  scenario 'Owner tries to delete question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete Question'

    expect(current_path).to eq questions_path
  end

  scenario 'Non-owner tries to delete question' do
    sign_in(user2)

    visit question_path(question)

    expect(current_path).to_not have_content 'Delete Question'
  end
end
