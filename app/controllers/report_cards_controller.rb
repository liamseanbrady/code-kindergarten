class ReportCardsController < ApplicationController
  def index
    @categories = Category.all
    category = params['type'] || 'All'
    filter = params['filter'] || ''
    @report_cards = ReportCard.filter(category, filter.to_sym)
  end
end
