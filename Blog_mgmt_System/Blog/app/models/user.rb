class User < ApplicationRecord
  belongs_to :role
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :status, inclusion: { in: %w[active inactive blocked] }
end
