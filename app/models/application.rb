class Application < ApplicationRecord
  enum status: [ :pending, :opened, :contacted ]

  belongs_to :match
  has_one :developer, through: :matches
  has_one :job, through: :matches
  has_one :company, through: :job
  validates :message, length: { maximum: 1000 }

end
