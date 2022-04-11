class Hint < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :hint_image
  acts_as_taggable

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def get_hint_image(width, height)
    if hint_image.present?
      hint_image.variant(resize_to_limit: [width, height]).processed
    end
  end

  validates :hint_contents, presence: true

end
