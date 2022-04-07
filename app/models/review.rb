class Review < ApplicationRecord
  belongs_to :user

  validates :season, inclusion: { in: [true, false] }
  validates :country_code, uniqueness: true

  def review_average
    if original_rate == nil
      (amusement_rate + gourmet_rate + security_rate + recommend_rate).to_f / 4
    else
      (amusement_rate + gourmet_rate + security_rate + recommend_rate + original_rate).to_f / 5
    end
  end
end
