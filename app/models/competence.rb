class Competence < ApplicationRecord
  validates :value, presence: true, length: { maximum: 15 }

end
