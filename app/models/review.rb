class Review < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :likes, dependent: :destroy

  validates :season, inclusion: { in: [true, false] }
  validates :country_code, uniqueness: { scope: [:country_code, :user_id] }
  validates :amusement_rate, presence: true
  validates :gourmet_rate, presence: true
  validates :security_rate, presence: true
  validates :recommend_rate, presence: true


  before_save :review_averages
  
  def review_averages
    if original_rate == nil
      self.review_average = (self.amusement_rate + self.gourmet_rate + self.security_rate + self.recommend_rate) / 4
    else
      self.review_average = (self.amusement_rate + self.gourmet_rate + self.security_rate + self.recommend_rate + self.original_rate) / 5
    end
  end

  def decimal
    if Review == nil or 1
      pass
    else
      self.round(1)
    end
  end

end
