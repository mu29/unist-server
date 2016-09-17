class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.boolean :confirmed, default: false
      t.string :confirm_token

      t.timestamps
    end
  end
end
