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
  validate :category_must_exist
 
scope :by_category, ->(category_id) {
  joins(:categories).where(categories: { id: category_id })
}
scope :by_author, ->(user_id) { where(user_id: user_id)}
  

  private
  def category_must_exist
    errors.add(:categories, "must exist") if categories.empty?
  end
end