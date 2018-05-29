class Company < ApplicationRecord
  has_many :jobs
  validates :name, :url, presence: true,  length: { maximum: 500 }
  validates :url, :format => URI::regexp(%w(http https))
end
