class ReportCard < ActiveRecord::Base
  has_many :likes
  belongs_to :category

  def self.popular(limit = 20)
    find_by_sql(popular_report_cards_query(limit))
  end

  def self.recent(limit = 20)
    all.order('created_at desc').limit(limit)
  end
  
  def self.type(name)
    return ReportCard.all if name == 'All'
    all.includes(:category).where.not(category: nil).map.select { |report_card| report_card.category.name == name }
  end

  def self.filter(category_name = 'All', *args)
    results = type(category_name)
    if args.include?(:popular)
      results = results.map.sort_by { |report_card| report_card.likes.count }.reverse
    elsif args.include?(:recent)
      results = results.map.sort_by { |report_card| report_card.created_at }.reverse
    elsif args.include?(:recent)
      results
    end
    results
  end

  private

  def self.popular_report_cards_query(limit)
    <<-SQL
    SELECT report_cards.*, COUNT(likes.report_card_id) AS like_count FROM report_cards
    LEFT JOIN likes
    ON report_cards.id=likes.report_card_id
    GROUP BY report_cards.id
    ORDER BY like_count DESC
    LIMIT #{limit};
    SQL
  end
end
