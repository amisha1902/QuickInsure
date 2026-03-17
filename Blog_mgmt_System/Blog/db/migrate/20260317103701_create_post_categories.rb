class CreatePostCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :post_categories do |t|
      t.references :post, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid,null: false, foreign_key: true

      t.timestamps
    end
  end
end
