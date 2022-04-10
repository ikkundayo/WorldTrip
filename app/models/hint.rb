class Hint < ApplicationRecord
  belongs_to :user

  has_one_attached :hint_image
  acts_as_taggable

  def get_hint_image(width, height)
    if hint_image.present?
      hint_image.variant(resize_to_limit: [width, height]).processed
    end
  end

  validates :hint_contents, presence: true

end
