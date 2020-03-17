require 'rails_helper'

feature 'Rate answer', %q{
  In order to help find the best answer
  As an auth user
  I want to be able to rate answer
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Non-owner of answer tries to rate up it', js: true do
    sign_in(user2)

    visit question_path(question)

    within('.rate') do
      expect(page).to have_content '0'
      click_on 'rate up'
      expect(page).to have_content '1'
    end
  end
end
