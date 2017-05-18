require 'rails_helper'

feature 'Argument' do
  scenario 'Visitor creates an argument' do
    visit new_argument_path
    fill_in 'argument_statement', with: statement='This statement is true'
    click_button 'Submit'
    expect(page).to have_text(statement)
    expect(page).to have_text('No one has voted on this proposition.')
  end
end
