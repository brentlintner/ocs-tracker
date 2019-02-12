class CreateEmailAlertUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :email_alert_users do |t|
      t.string :email, null: false
      t.boolean :confirmed, null: false, default: false
      t.timestamps
    end

    add_index :email_alert_users, :email, unique: true
  end
end
