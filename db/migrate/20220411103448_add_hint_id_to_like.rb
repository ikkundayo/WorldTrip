class AddHintIdToLike < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :hint_id, :integer
  end
end
