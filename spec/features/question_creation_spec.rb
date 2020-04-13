require 'rails_helper'

feature 'Question creation', %q{
  In order to solve my problem
  As an auth user
  I want to be able to create question
} do
  given(:user) { create(:user) }

  scenario 'Signed in user tries to create question' do
    sign_in(user)

    click_on 'Ask bastard question'
    fill_in 'Title', with: '?'
    fill_in 'Body', with: '???'
    click_on 'Create Question'

    expect(page).to have_content 'Question'
    expect(page).to have_content 'Title: ?'
  end

  scenario 'Non-signed in user tries to create question' do
    visit new_question_path
    expect(current_path).to eq new_user_session_path
  end
end
