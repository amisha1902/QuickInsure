class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :post,type: :uuid, null: false, foreign_key: true
      t.string :message
      t.string :notification_type
      t.boolean :is_read

      t.timestamps
    end
  end
end
