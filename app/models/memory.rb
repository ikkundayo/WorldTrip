class Memory < ApplicationRecord
  belongs_to :user

  has_one_attached :memory_image

  def get_memory_image(width, height)
    if memory_image.present?
      memory_image.variant(resize_to_limit: [width, height]).processed
    end
  end

end
