class Application < ApplicationRecord
  belongs_to :match
  has_one :developer, through: :matchs
  has_one :job, through: :matchs
  has_one :company, through: :job
  validates :message, length: { maximum: 1000 }
end
