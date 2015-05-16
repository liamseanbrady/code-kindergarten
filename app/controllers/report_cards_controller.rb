class ReportCardsController < ApplicationController
  def index
    @report_cards = ReportCard.popular
  end
end
