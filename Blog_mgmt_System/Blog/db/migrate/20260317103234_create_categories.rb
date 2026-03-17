class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :category_name
      t.text :description

      t.timestamps
    end
  end
end
