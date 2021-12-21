class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :email_hmac
      t.string :password_digest
      t.string :reset_password_token
      t.string :last_name
      t.string :first_name
      t.string :name
      t.string :current_sign_in_ip

      t.string :skype
      t.string :linkedin
      t.string :twitter

      t.integer :failed_attempts

      t.datetime :reset_password_sent_at
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at

      t.integer :role

      t.timestamps
    end

    add_index :users, [:email], using: :btree
    add_index :users, [:email_hmac], using: :btree
  end
end
