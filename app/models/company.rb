class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :employees
  has_many :recruiters, through: :employees, dependent: :destroy
  validates :name, :url, presence: true,  length: { maximum: 500 }
  validates :url, :format => URI::regexp(%w(http https))
end
