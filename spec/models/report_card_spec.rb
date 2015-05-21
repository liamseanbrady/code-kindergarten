require 'rails_helper'

describe ReportCard do
  it { is_expected.to have_many(:likes) }

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
end
