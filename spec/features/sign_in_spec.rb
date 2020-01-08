require 'rails_helper'

feature 'User sign in', %q{
  In order to ask questions
  As an user
  I want to be able to sign in
} do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'mr.Joposranchik@gmail.com', password: '1234')

    visit new_user_session_path
    fill_in 'Email', with: 'mr.Joposranchik@gmail.com'
    fill_in 'Password', with: '1234'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfuly.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'mr.Wolf@gmail.com'
    fill_in 'Password', with: '1234'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
