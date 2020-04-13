require 'rails_helper'

feature 'Edit question', %q{
  In order to solve improve my question
  As an author of an question
  I want to be able to edit an question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Non-signed in user tries to edit an question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit question'
  end

  scenario 'Author tries to edit his answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Edit question'
    fill_in 'Title', with: 'Edited title'
    fill_in 'Body', with: 'Edited body'

    click_on 'Update Question'

    within '.question' do
      expect(page).to_not have_selector 'textarea'
      expect(page).to have_content 'Edited title'
      expect(page).to have_content 'Edited body'
    end
  end
end
