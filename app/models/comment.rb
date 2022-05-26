class Comment < ApplicationRecord
  belongs_to :user

  has_many :notifications, dependent: :destroy

  validates :comment, presence: true
end
