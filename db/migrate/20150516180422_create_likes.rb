class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :status
      t.integer :report_card_id
      t.timestamps
    end
  end
end
