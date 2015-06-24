require 'rails_helper'

describe ReportCard do
  it { is_expected.to have_many(:likes) }
  it { is_expected.to belong_to(:category) }

  describe '.popular' do
    it 'returns an empty array if there are no report cards' do
      expect(ReportCard.popular).to eq([])
    end

    it 'returns an array with one report card if there is one report card' do
      report_card = Fabricate(:report_card)

      expect(ReportCard.popular).to eq([report_card])
    end

    it 'orders report cards by most number of likes' do
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card)
      report_card_two.likes << Fabricate(:like)

      expect(ReportCard.popular.first).to eq(report_card_two)
    end

    it 'returns an array of report cards if there is more than one' do
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card)
      report_card_two.likes << Fabricate(:like)

      expect(ReportCard.popular).to match_array([report_card_two, report_card_one, report_card_three])
    end

    it 'returns an array of 20 report cards if there are more than 20' do
      21.times do |number|
        eval("report_card_#{number.next} = Fabricate(:report_card)")
      end

      expect(ReportCard.popular.count).to eq(20)
    end
  end

  describe '.recent' do
    it 'returns an empty array if there are no report cards' do
      expect(ReportCard.recent).to eq([])
    end

    it 'returns an array with one report card if there is one report card' do
      report_card = Fabricate(:report_card)

      expect(ReportCard.recent).to eq([report_card])
    end

    it 'orders report cards in reverse chronological order' do
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card)

      expect(ReportCard.recent.first).to eq(report_card_three)
    end

    it 'returns an array of report cards if there is more than one' do
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card)

      expect(ReportCard.recent).to match_array([report_card_three, report_card_two, report_card_one])
    end
    
    it 'returns an array of 20 report cards if there are more than 20' do
      21.times do |number|
        eval("report_card_#{number.next} = Fabricate(:report_card)")
      end

      expect(ReportCard.recent.count).to eq(20)
    end
  end

  describe '.type' do
    it 'returns an empty array if no report cards have an associated category' do
      expect(ReportCard.type('Ruby')).to eq([])
    end
      
    it 'returns an array of one report card if only one has an associated category' do
      ruby = Fabricate(:category, name: 'Ruby')
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card, category: ruby)

      expect(ReportCard.type('Ruby')).to eq([report_card_three])
    end

    it 'returns an array of many report cards if more than one has an associated category' do
      ruby = Fabricate(:category, name: 'Ruby')
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card, category: ruby)
      report_card_three = Fabricate(:report_card, category: ruby)

      expect(ReportCard.type('Ruby')).to match_array([report_card_two, report_card_three])
    end
  end

  describe '.filter' do
    it 'filters by category and then sorts by popularity when both are present' do
      ruby = Fabricate(:category, name: 'Ruby')
      report_card_one = Fabricate(:report_card, category: ruby)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card, category: ruby)
      report_card_four = Fabricate(:report_card, category: ruby)
      report_card_three.likes << Fabricate(:like)

      expect(ReportCard.filter('Ruby', :popular)).to eq([report_card_three, report_card_four, report_card_one])
    end

    it 'filters by category and then sorts by reverse chronological order when both are present' do
      ruby = Fabricate(:category, name: 'Ruby')
      report_card_one = Fabricate(:report_card, category: ruby)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card, category: ruby)
      report_card_four = Fabricate(:report_card, category: ruby)

      expect(ReportCard.filter('Ruby', :recent)).to eq([report_card_four, report_card_three, report_card_one])
    end

    it 'filters by category and then sorts by chronological order when both are present' do
      ruby = Fabricate(:category, name: 'Ruby')
      report_card_one = Fabricate(:report_card, category: ruby)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card, category: ruby)
      report_card_four = Fabricate(:report_card, category: ruby)

      expect(ReportCard.filter('Ruby', :oldest)).to eq([report_card_one, report_card_three, report_card_four])
    end

    it 'filters by category alone when other parameters are not present' do 
      ruby = Fabricate(:category, name: 'Ruby')
      report_card_one = Fabricate(:report_card, category: ruby)
      report_card_two = Fabricate(:report_card)
      report_card_three = Fabricate(:report_card, category: ruby)
      report_card_four = Fabricate(:report_card, category: ruby)
      report_card_three.likes << Fabricate(:like)

      expect(ReportCard.filter('Ruby')).to eq([report_card_one, report_card_three, report_card_four])
    end
  end
end
