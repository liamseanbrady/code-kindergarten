require 'rails_helper'

describe ReportCardsController do
  describe 'index' do
    it 'assigns popular report cards to report_cards' do
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)

      get :index

      expect(assigns(:report_cards)).to match_array([report_card_one, report_card_two])
    end
  end
end
