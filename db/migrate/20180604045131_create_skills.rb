class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :level
      t.references :skillable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
