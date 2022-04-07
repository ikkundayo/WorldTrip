class CreateMemories < ActiveRecord::Migration[6.1]
  def change
    create_table :memories do |t|
      t.integer  :user_id, null: false
      t.string  :country_code, null: false
      t.text  :memory_contents, null: false

      t.timestamps
    end
  end
end
