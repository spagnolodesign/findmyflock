class Company < ApplicationRecord
  has_many :jobs
  has_many :developers, through: :job
  has_many :applications, through: :job
  validates :name, :url, presence: true,  length: { maximum: 500 }
  validates :url, :format => URI::regexp(%w(http https))
end
