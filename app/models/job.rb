class Job < ApplicationRecord

  belongs_to :company
  geocoded_by :location
  validates :title, :description, presence: true,  length: { maximum: 500 }
  validates :city, :zip_code, :state, :country, presence: true,  length: { maximum: 100 }
  validates :max_salary, numericality: { only_integer: true, greater_than: 0}
  validates :remote, inclusion: { in: [["remote"], ["office"], ["remote", "office"]]}
  validates :level, presence: true,  inclusion: { in: 1..5 }
  validates :employment_type, presence: true, length: { maximum: 100 }
  validates :benefits, :cultures, length: { minimum: 1, maximum: 10 }
  validates :skills, length: { minimum: 1, maximum: 3 }
  before_save :geocode
  before_save :generate_job_skills_array


  scope :only_remote_jobs, -> {where(remote: ["remote"])}
  scope :only_office_jobs, -> {where(remote: ["office"])}
  scope :remote_or_office_jobs, -> {where("remote = ARRAY['remote']::text[] OR remote = ARRAY['remote', 'office']::text[]")}
  scope :match_skills_type, -> (array) { where("skills_array <@ ARRAY[?]::text[]", array) }
  scope :filter_by_user_salary, -> (value) {where("max_salary >= ?", value)}
  scope :filter_by_benefits, -> (array) { where("benefits @> ARRAY[?]::text[]", array) }
  scope :filter_by_cultures, -> (array) { where("cultures @> ARRAY[?]::text[]", array) }
  scope :filter_by_employment_type, -> (value) { where("employment_type = ?", value) }

  def location
    [city, zip_code, state, country].compact.join(', ')
  end

  private

  def generate_job_skills_array
    if skills_changed?
      skills.each do |key, value|
        skills_array <<  "#{key}/#{value}"
      end
    end
  end


end
