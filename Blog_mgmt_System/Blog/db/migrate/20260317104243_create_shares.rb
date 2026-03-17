class CreateShares < ActiveRecord::Migration[8.1]
  def change
    create_table :shares, id: :uuid do |t|
      t.references :user,type: :uuid, null: false, foreign_key: true
      t.references :post, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
