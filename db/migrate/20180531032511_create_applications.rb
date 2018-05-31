class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.text :message
      t.references :developer, foreign_key: true
      t.references :job, foreign_key: true
      t.timestamps
    end
  end
end
