class CreateReportCards < ActiveRecord::Migration
  def change
    create_table :report_cards do |t|
      t.string :title, :grade
      t.string :visibility, default: 'private'
      t.integer :session_length
      t.text :description
      t.timestamps
    end
  end
end
