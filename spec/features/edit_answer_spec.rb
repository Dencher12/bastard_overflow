require 'rails_helper'

feature 'Edit answer', %q{
  In order to solve improve my answer
  As an author of an answer
  I want to be able to edit an answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Non-signed in user tries to edit an answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  scenario 'Author tries to edit his answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Edit'
      fill_in 'Your Answer', with: 'Edited answer'
      click_on 'Answer'

      expect(page).to_not have_selector 'textarea'
      expect(page).to_not have_content answer.body
      expect(page).to have_content 'Edited answer'
    end
  end
  scenario 'Non-author tries to edit an answer'
end
