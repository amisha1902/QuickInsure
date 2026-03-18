class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :message, presence: true
  validates :is_read, inclusion: { in: [true, false] }
  validates :notification_type, presence: true
end
