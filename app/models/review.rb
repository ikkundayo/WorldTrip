class Review < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :season, inclusion: { in: [true, false] }
  validates :country_code, uniqueness: { scope: [:country_code, :user_id] }

  def review_averages
    if original_rate == nil
      (amusement_rate + gourmet_rate + security_rate + recommend_rate) / 4
    else
      (amusement_rate + gourmet_rate + security_rate + recommend_rate + original_rate) / 5
    end
  end

end
