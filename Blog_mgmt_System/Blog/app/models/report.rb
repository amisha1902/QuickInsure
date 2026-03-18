class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :reason, presence: true
  validates :status, inclusion: { in: %w[pending reviewed resolved] }
  validates :description, presence: true
end
