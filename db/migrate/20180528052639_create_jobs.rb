class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :remote, array: true, default: []
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :country
      t.boolean :active, default: true
      t.float :latitude
      t.float :longitude
      t.integer :max_salary
      t.text :skills_array, array: true, default: []
      t.string :employment_type
      t.text :benefits, array: true, default: []
      t.text :cultures, array: true, default: []
      t.boolean :can_sponsor, default: false
      t.references :company, foreign_key: true
      t.timestamps
    end
  end
end
