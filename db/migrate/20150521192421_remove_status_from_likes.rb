class RemoveStatusFromLikes < ActiveRecord::Migration
  def change
    remove_column :likes, :status
  end
end
