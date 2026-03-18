class Post < ApplicationRecord
  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :title, presence: true
  validates :content, presence:true
  validates :status, presence: true
end
 