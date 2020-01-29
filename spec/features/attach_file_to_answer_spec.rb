require 'rails_helper'

feature 'Attach a file to an answer', %q{
  In order to supplement my answer
  As an author of an answer
  I want to be able to attach a file
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Auth user tries to attach file when answers question', js: true do
    fill_in 'Your Answer', with: 'Ultimate Answer'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Answer'
    
    within('.answers') do
      expect(page).to have_link 'rails_helper.rb'
    end
  end
end