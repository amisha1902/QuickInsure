class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports, id: :uuid do |t|
      t.references :user,type: :uuid, null: false, foreign_key: true
      t.references :post, type: :uuid, null: false, foreign_key: true
      t.string :reason
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
