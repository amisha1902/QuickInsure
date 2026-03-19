class User < ApplicationRecord
  belongs_to :role
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :status, inclusion: { in: %w[active inactive blocked] }
  scope :active, -> { where(status: 'active') }
end
