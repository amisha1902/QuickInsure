class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :status, default: "inactive"

      t.timestamps
    end
  end
end
