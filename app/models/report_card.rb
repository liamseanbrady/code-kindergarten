class ReportCard < ActiveRecord::Base
  has_many :likes

  def self.popular(limit = 20)
    find_by_sql(popular_report_cards_query(limit))
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
