require 'rails_helper'

feature 'Home Page' do
  scenario 'it loads' do
    visit root_path
    expect(page).to have_content "Find the company that values the unique you"
    expect(page).to have_link "Join"
    expect(page).to have_link "Login"
  end
end
