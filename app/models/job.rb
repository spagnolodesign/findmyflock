class Job < ApplicationRecord
  belongs_to :company
  has_many :matches, dependent: :destroy
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :developers, through: :matches
  has_many :applications, through: :matches
  geocoded_by :location
  validates :title, :description, presence: true,  length: { maximum: 2000 }
  # validates :city, :zip_code, :state, :country, presence: true,  length: { maximum: 100 }
  validates :max_salary, numericality: { only_integer: true, greater_than: 0}, on: :update
  validates :remote, inclusion: { in: [["remote"], ["office"], ["remote", "office"]]}, on: :create
  validates :employment_type, presence: true, length: { maximum: 100 }, on: :update
  validates :benefits, :cultures, length: { minimum: 1, maximum: 10 }, on: :update
  before_save :geocode, if: :city_changed?

  scope :active, -> {where(active: true)}
  scope :remote_or_office_jobs, -> (array) {where("remote <@ ARRAY[?]::text[] OR remote @> ARRAY[?]::text[]", array, array)}
  scope :can_sponsor, -> {where("can_sponsor = true ")}
  scope :match_skills_type, -> (array) { where.not(skills_array: []).where("skills_array <@ ARRAY[?]::text[]", array) }
  scope :filter_by_user_salary, -> (value) {where("max_salary >= ?", value)}
  scope :filter_by_benefits, -> (array) { where("benefits @> ARRAY[?]::text[]", array) }
  scope :filter_by_cultures, -> (array) { where("cultures @> ARRAY[?]::text[]", array) }
  scope :filter_by_employment_type, -> (value) { where("employment_type = ?", value) }

  def location
    [city, zip_code, state, country].compact.join(', ')
  end

  def deactivate
    self.active = false
  end

end
