require 'rails_helper'

feature 'Attach a file to a question', %q{
  In order to supplement my question
  As an author of a question
  I want to be able to attach a file
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Auth user try to attach file when asks question', js: true do
    fill_in 'Title', with: '?'
    fill_in 'Body', with: '???'
    click_link 'add attachment'

    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create Question'
    expect(page).to have_link 'rails_helper.rb'
  end
end
