require 'rails_helper'

feature 'Mark the best answer', %q{
  In order to show which answer helped me
  As an author of an question
  I want to be able to mark the best answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Non-signed in user tries to mark the best answer' do
    visit question_path(question)
    expect(page).to_not have_content 'The best'
  end

  scenario 'Author tries to mark the best answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'The best'

    within ".answer_block.answer_id_#{answer.id}" do
      expect(page).to have_selector 'img'
    end
  end
end
