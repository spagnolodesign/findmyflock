# frozen_string_literal: true

class DeviseCreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
     t.string   :confirmation_token
     t.datetime :confirmed_at
     t.datetime :confirmation_sent_at
     t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      t.string   :first_name
      t.string   :last_name
      t.boolean  :need_us_permit, default: false
      t.string   :linkedin_url
      t.string   :github_url
      t.integer :min_salary
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :country
      t.float :latitude, default: nil
      t.float :longitude,  default: nil
      t.text :skills_array, array: true, default: []
      t.text :remote, array: true, default: []
      t.integer :mobility, default: 30
      t.boolean :full_mobility
      t.boolean :first_login, default: false
      t.timestamps null: false
    end

    add_index :developers, :email,                unique: true
    add_index :developers, :reset_password_token, unique: true
    # add_index :developers, :confirmation_token,   unique: true
    # add_index :developers, :unlock_token,         unique: true
  end
end
