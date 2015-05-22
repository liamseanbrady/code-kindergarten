require 'rails_helper'

feature 'guest views users report cards' do
  scenario 'via sign in page sneak peak' do
    visit register_path
    expect(page).to have_content('Register')
    click_on 'Take a sneak peak at the site first'

    expect(page).not_to have_content('Welcome')
    expect(page).to have_content('Popular Report Cards')
  end

  scenario 'sorted by most recent' do
    report_card_one = Fabricate(:report_card, title: 'Ruby is Awesome')
    report_card_two = Fabricate(:report_card, title: 'TDD is Awesome')
    visit register_path
    click_on 'Take a sneak peak at the site first'

    select('Most recent')

    click_button 'Filter'
    first_report_card = find(:xpath, "//*[contains('@class', 'report-card-box')]")
    expect(first_report_card.text).to eq(report_card_two.title)
  end
end
