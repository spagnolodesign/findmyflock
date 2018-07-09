class AddVettedToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :vetted, :boolean, default: false
  end
end
