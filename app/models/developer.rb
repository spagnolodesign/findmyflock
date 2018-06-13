class Developer < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :applications, through: :matches
  has_one_attached :avatar
  has_many_attached :resumes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  geocoded_by :developer_location
  before_validation :email_downcase
  before_validation :capitalize_name
  after_validation :geocode, on: :update
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :password_complexity
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }, on: :update
  validates :city, :country, :state, presence: true, if: :wants_office, on: :update
  # validates :latitude, :longitude, presence: :true, on: :update
  validates :min_salary, numericality: { only_integer: true, greater_than: 0, less_than: 200000 }, on: :update
  validates :remote, inclusion: { in: [['remote'], ['office'], %w[remote office]] }, on: :update
  before_update :check_cordinates, if: :city_changed?
  before_update :set_mobility


  def developer_location
    [city, zip_code, state, country].compact.join(', ')
  end

  def wants_office
    self.remote != ['remote']
  end

  def set_mobility
    self.mobility = nil if full_mobility
  end

   def check_cordinates
     errors.add(:city, "There is a problem with your location. Please try again") if !latitude
   end

  def email_downcase
    email = email.strip.downcase if email
  end

  def capitalize_name
    first_name = first_name.capitalize if first_name
    last_name = last_name.capitalize if last_name
  end


  def set_url
    linkedin = "https://linkedin.com/in/#{linkedin_url}"
    github = "https://github.com/#{github_url}"
    self.github_url.empty? ? self.github_url = nil : self.github_url = github
    self.linkedin_url.empty? ? self.linkedin_url = nil : self.linkedin_url = linkedin
  end

  # def first_login
  #   self.first_login = true
  # end

  def full_name
    first_name + " " + last_name if first_name && last_name
  end


  def password_complexity
    if !password.nil? && password !~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/
      errors.add :password, 'Password must include at least one lowercase letter, one uppercase letter, and one digit'
    end
  end

  def matched_job
    if full_mobility
      if need_us_permit
        Job.active.remote_or_office_jobs(remote).match_skills_type(skills_array).can_sponsor
      else
        Job.active.remote_or_office_jobs(remote).match_skills_type(skills_array)
      end
    else
      if need_us_permit
        Job.active.check_location(mobility, latitude, longitude).remote_or_office_jobs(remote).match_skills_type(skills_array).can_sponsor
      else
        Job.active.check_location(mobility, latitude, longitude).remote_or_office_jobs(remote).match_skills_type(skills_array)
      end
    end
  end

  # .check_location(mobility, latitude, longitude)
  def self.check_for_first_matches
    all.each do |developer|
      developer.matched_job.each do |job|
        Match.create(developer_id: developer.id, job_id: job.id)
      end
    end
  end

  def self.check_for_new_matches
    string = ''
    all.each do |developer|
      new_matches = 0
      developer.matched_job.each do |job|
        match = Match.new(developer_id: developer.id, job_id: job.id)
        new_matches += 1 if match.save
      end
      if new_matches > 0
        string << "Sending an email to #{developer.first_name}. He has #{new_matches} new matches!"
      end
    end
    p string
  end
end
