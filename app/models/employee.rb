class Employee < ApplicationRecord
  belongs_to :company
  has_one :recruiter
end
