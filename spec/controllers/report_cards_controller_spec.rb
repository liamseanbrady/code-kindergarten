require 'rails_helper'

describe ReportCardsController do
  describe 'index' do
    it 'assigns all report cards to report_cards ivar' do
      report_card_one = Fabricate(:report_card)
      report_card_two = Fabricate(:report_card)

      get :index

      expect(assigns(:report_cards)).to match_array([report_card_one, report_card_two])
    end

    context 'with filter parameter' do
      it 'filters report cards by most recent' do
        report_card_one = Fabricate(:report_card, created_at: Time.now - 1.day)
        report_card_two = Fabricate(:report_card)

        get :index, { filter: 'recent' }

        expect(assigns(:report_cards)).to eq([report_card_two, report_card_one])
      end

      it 'filters report cards by oldest' do
        report_card_one = Fabricate(:report_card, created_at: Time.now - 1.day)
        report_card_two = Fabricate(:report_card)

        get :index, { filter: 'oldest' }

        expect(assigns(:report_cards)).to eq([report_card_one, report_card_two])
      end

      it 'filters report cards by most popular' do
        report_card_one = Fabricate(:report_card, created_at: Time.now - 1.day)
        report_card_two = Fabricate(:report_card)
        report_card_two.likes << Fabricate(:like)

        get :index, { filter: 'popular' }

        expect(assigns(:report_cards)).to eq([report_card_two, report_card_one])
      end
    end

    context 'with type paramter' do
      it 'sets the categories ivar to all categories' do
        ruby = Fabricate(:category, name: 'Ruby')
        javascript = Fabricate(:category, name: 'Javascript')

        get :index
        
        expect(assigns(:categories)).to match_array([ruby, javascript])
      end

      it 'filters report cards by type' do
        ruby = Fabricate(:category, name: 'Ruby')
        report_card_one = Fabricate(:report_card)
        report_card_two = Fabricate(:report_card, category: ruby)

        get :index, { type: 'Ruby' }

        expect(assigns(:report_cards)).to eq([report_card_two])
      end
    end

    context 'with both filter and type parameters' do
      it 'filters report cards by type and filter parameter' do
        javascript = Fabricate(:category, name: 'Javascript')
        report_card_one = Fabricate(:report_card, title: 'TDD is Good')
        report_card_two = Fabricate(:report_card, title: 'Javascript is Good', category: javascript)
        report_card_three = Fabricate(:report_card, title: 'Javascript is Awesome', category: javascript)
        report_card_four = Fabricate(:report_card, title: 'Javascript is Average', category: javascript)
        report_card_three.likes << Fabricate(:like)

        get :index, { type: 'Javascript', filter: 'popular' }

        expect(assigns(:report_cards)).to eq([report_card_three, report_card_four, report_card_two])
      end
    end
  end
end
