require 'rails_helper'

feature 'User sign up', %q{
  In order to ask questions
  As an user
  I want to be able to sign up
} do
  given(:user) { create(:user) }

  scenario "User tries to sign up and email isn't in the db" do
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'User tries to sign up and email already exists in the db' do
    click_on 'Sign up'
    expect(page).to have_content 'Email has already been taken'
  end
end
