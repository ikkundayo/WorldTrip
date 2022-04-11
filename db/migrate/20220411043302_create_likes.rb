class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :memory_id
      t.integer :user_id

      t.timestamps
      t.index [:user_id, :memory_id], unique: true
    end
  end
end
