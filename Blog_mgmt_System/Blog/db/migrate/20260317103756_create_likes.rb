class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.references :user,type: :uuid, null: false, foreign_key: true
      t.references :post,type: :uuid, null: false, foreign_key: true
      t.string :like_type 
      t.timestamps
    end
  end
end
