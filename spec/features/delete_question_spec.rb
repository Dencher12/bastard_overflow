require 'rails_helper'

feature 'Delete question' do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }

  scenario 'Owner tries to delete question' do
    log_in(user)

    click_on 'Ask bastard question'
    fill_in 'Title', with: '?'
    fill_in 'Body', with: '???'
    click_on 'Create Question'
    click_on 'Delete Question'

    expect(current_path).to eq questions_path
  end
end
