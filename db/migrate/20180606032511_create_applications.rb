class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.text :message
      t.integer :status, default: 0
      t.references :match, foreign_key: true
      t.timestamps
    end
  end
end
