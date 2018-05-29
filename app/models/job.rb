class Job < ApplicationRecord

  belongs_to :company
  geocoded_by :location
  validates :title, :description, presence: true,  length: { maximum: 500 }
  validates :city, :zip_code, :state, :country, presence: true,  length: { maximum: 100 }
  validates :max_salary, numericality: { only_integer: true, greater_than: 0}
  validates :remote, inclusion: { in: [["remote"], ["office"], ["remote", "office"]]}
  validates :level, presence: true,  inclusion: { in: 1..5 }
  validates :employment_type, presence: true, length: { maximum: 100 }
  validate  :check_benefits, :check_cultures
  validates :skills, :benefits, :cultures, length: { minimum: 1, maximum: 10 }
  before_save :geocode

  scope :filter_by_benefits, -> (array) { where("benefits @> ARRAY[?]::text[]", array) }
  scope :filter_by_cultures, -> (array) { where("cultures @> ARRAY[?]::text[]", array) }
  scope :filter_by_employment_type, -> (value) { where("employment_type = ?", value) }
  scope :filter_by_salary, -> (value) {where("max_salary > ?", value)}

  def location
    [city, zip_code, state, country].compact.join(', ')
  end

end
