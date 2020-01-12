require 'rails_helper'

feature 'View of questions list', %q{
  In order to solve my problem
  As an user
  I want to be able to view of questions list
} do
  scenario 'User tries to view of questions list' do
    click_on 'List of bastard questions'
    expect(current_path).to eq questions_path
  end
end
