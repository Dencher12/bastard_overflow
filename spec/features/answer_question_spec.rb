require 'rails_helper'

feature 'Answer question', %q{
  In order to solve someone's problem
  As an auth user
  I want to be able to answer question
} do
  given(:user) { create(:user) }

  scenario 'Signed in user tries to answer question' do
    log_in(user)

    question = build(:question)
    question.user = user
    question.save

    visit question_path(question)

    fill_in 'Your Answer', with: 'Ultimate Answer'
    click_on 'Answer'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Ultimate Answer'
  end
end