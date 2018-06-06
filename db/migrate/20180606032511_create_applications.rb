class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.text :message
      t.boolean :application_readed, default: false
      t.boolean :contact_candidate, default: false
      t.references :match, foreign_key: true
      t.timestamps
    end
  end
end
