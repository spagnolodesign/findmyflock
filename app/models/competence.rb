class Competence < ApplicationRecord
  validates :value, presence: true, length: { maximum: 30 }

end
