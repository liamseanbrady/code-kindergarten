class AddCategoryIdForeignKeyToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :category_id, :integer
  end
end
