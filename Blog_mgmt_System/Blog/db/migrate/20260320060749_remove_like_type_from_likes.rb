class RemoveLikeTypeFromLikes < ActiveRecord::Migration[8.1]
  def change
    remove_column :likes, :like_type, :string
  end
end
