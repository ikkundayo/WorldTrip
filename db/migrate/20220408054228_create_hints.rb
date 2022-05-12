class CreateHints < ActiveRecord::Migration[6.1]
  def change
    create_table :hints do |t|
      t.integer  :user_id, null: false
      t.string  :country_code, null: false
      t.text  :hint_contents, null: false

      t.timestamps
    end
  end
end
