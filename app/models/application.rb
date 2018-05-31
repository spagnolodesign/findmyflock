class Application < ApplicationRecord
  belongs_to :developer
  belongs_to :job
  has_one :company, through: :job

  validates :message, length: { maximum: 1000 }

end
