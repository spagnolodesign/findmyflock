class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :job, foreign_key: true
      t.references :developer, foreign_key: true
      t.timestamps
    end
  end
end
