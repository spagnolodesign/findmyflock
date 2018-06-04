class Job < ApplicationRecord
  has_many :skills, as: :skillable
  belongs_to :company
  geocoded_by :location
  validates :title, :description, presence: true,  length: { maximum: 500 }
  validates :city, :zip_code, :state, :country, presence: true,  length: { maximum: 100 }
  validates :max_salary, numericality: { only_integer: true, greater_than: 0}
  validates :remote, inclusion: { in: [["remote"], ["office"], ["remote", "office"]]}
  validates :level, presence: true,  inclusion: { in: 1..5 }
  validates :employment_type, presence: true, length: { maximum: 100 }
  validates :benefits, :cultures, length: { minimum: 1, maximum: 10 }
  before_save :geocode, if: :city_changed?



  scope :remote_or_office_jobs, -> (array) {where("remote <@ ARRAY[?]::text[] OR remote @> ARRAY[?]::text[]", array, array)}
  scope :match_skills_type, -> (array) { where.not(skills_array: []).where("skills_array <@ ARRAY[?]::text[]", array) }
  scope :filter_by_user_salary, -> (value) {where("max_salary >= ?", value)}
  scope :filter_by_benefits, -> (array) { where("benefits @> ARRAY[?]::text[]", array) }
  scope :filter_by_cultures, -> (array) { where("cultures @> ARRAY[?]::text[]", array) }
  scope :filter_by_employment_type, -> (value) { where("employment_type = ?", value) }

  def location
    [city, zip_code, state, country].compact.join(', ')
  end

end
