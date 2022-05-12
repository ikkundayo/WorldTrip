class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer  :user_id, null: false
      t.integer  :country_id, null: false
      t.boolean :season, null: false
      t.string :country_code, null: false, unique: true
      t.float  :amusement_rate, null: false
      t.string :amusement_voice
      t.float  :gourmet_rate, null: false
      t.string :gourmet_voice
      t.float  :security_rate, null: false
      t.string :security_voice
      t.float  :recommend_rate, null: false
      t.string :recommend_voice
      t.string :original_category
      t.float  :original_rate
      t.string :original_voice
      t.float  :review_average
      t.string :area
      t.string :code


      t.timestamps
    end
  end
end
