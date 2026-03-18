class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :like_type,  inclusion: { in: %w[like dislike]}
end
