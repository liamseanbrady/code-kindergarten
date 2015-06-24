require 'rails_helper'

feature 'guest views users report cards' do
  scenario 'via sign in page sneak peak' do
    visit register_path
    expect(page).to have_content('Register')
    
    click_on 'Take a sneak peak at the site first'

    expect(page).not_to have_content('Welcome')
    expect(page).to have_content('Popular Report Cards')
  end

  scenario 'sorted in reverse chronological order' do
    report_card_one = Fabricate(:report_card, title: 'Ruby is Awesome')
    report_card_two = Fabricate(:report_card, title: 'TDD is Awesome')

    visit register_path
    click_on 'Take a sneak peak at the site first'

    select('Most recent')
    click_button 'Filter'

    first_report_card = all('.report-card-box').first.find('h4')
    expect(first_report_card.text).to eq(report_card_two.title)
  end

  scenario 'sorted in chronological order after sorting in reverse chronological order' do
    report_card_one = Fabricate(:report_card, title: 'Ruby is Awesome')
    report_card_two = Fabricate(:report_card, title: 'TDD is Awesome')

    visit register_path
    click_on 'Take a sneak peak at the site first'

    select('Most recent')
    click_button 'Filter'

    select('Oldest')
    click_button 'Filter'

    first_report_card = all('.report-card-box').first.find('h4')
    expect(first_report_card.text).to eq(report_card_one.title)
  end

  scenario 'sorted by most popular report card first' do
    report_card_one = Fabricate(:report_card, title: 'Ruby is Awesome')
    report_card_two = Fabricate(:report_card, title: 'TDD is Awesome')
    report_card_two.likes << Fabricate(:like)

    visit register_path
    click_on 'Take a sneak peak at the site first'

    select('Popular')
    click_button 'Filter'

    first_report_card = all('.report-card-box').first.find('h4')
    expect(first_report_card.text).to eq(report_card_two.title)
  end

  scenario 'filtered by programming language type' do
    javascript = Fabricate(:category, name: 'Javascript')
    report_card_one = Fabricate(:report_card, title: 'Javascript is Awesome', category: javascript)
    report_card_two = Fabricate(:report_card, title: 'TDD is Awesome')

    visit register_path
    click_on 'Take a sneak peak at the site first'

    select('Javascript')
    click_button 'Filter'

    first_report_card = all('.report-card-box').first.find('h4')
    expect(first_report_card.text).to eq(report_card_one.title)

    all_report_cards = all('.report-card-box')
    expect(all_report_cards.size).to eq(1)
  end
  
  scenario 'filtered by programming language type and most popular' do
    javascript = Fabricate(:category, name: 'Javascript')
    report_card_one = Fabricate(:report_card, title: 'Javascript is Awesome', category: javascript)
    report_card_two = Fabricate(:report_card, title: 'TDD is Awesome')
    report_card_three = Fabricate(:report_card, title: 'Javascript is Bad', category: javascript)
    report_card_four = Fabricate(:report_card, title: 'Javascript is Okay', category: javascript)
    report_card_three.likes << Fabricate(:like)

    visit register_path
    click_on 'Take a sneak peak at the site first'

    select('Javascript')
    click_button 'Filter'

    first_report_card = all('.report-card-box').first.find('h4')
    expect(first_report_card.text).to eq(report_card_three.title)

    all_report_cards = all('.report-card-box')
    expect(all_report_cards.size).to eq(3)
  end
end
