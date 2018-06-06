class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.references :company, foreign_key: true
      t.references :recruiter, foreign_key: true
      t.timestamps
    end
  end
end
