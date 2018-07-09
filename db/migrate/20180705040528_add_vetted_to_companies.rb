class AddVettedToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :vetted, :boolean, default: false
  end
end
