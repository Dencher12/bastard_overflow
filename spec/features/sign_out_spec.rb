require 'rails_helper'

feature 'User sign out', %q{
  In order to change account
  As an user
  I want to be able to sign out
} do
  given(:user) { create(:user) }

  scenario 'Registered user tries to sign out' do
    log_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path

    click_on 'Exit'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Non-registered user tries to sign out' do
    visit root_path
    expect(page).to_not have_content 'Exit'
  end
end
