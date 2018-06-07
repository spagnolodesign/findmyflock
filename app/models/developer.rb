class Developer < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :applications, through: :matches
  geocoded_by :location

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_validation :email_downcase
  before_validation :capitalize_name
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :password_complexity
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }, on: :update
  validates :city, :zip_code, :country, presence: true, length: { maximum: 100 }
  validates :min_salary, numericality: { only_integer: true, greater_than: 0 }, on: :update
  validates :level, presence: true, inclusion: { in: 1..5 }, on: :update
  validates :remote, inclusion: { in: [['remote'], ['office'], %w[remote office]] }, on: :update

  validates :level, presence: true, inclusion: { in: 1..5 }, on: :update
  before_save :geocode, if: :city_changed?



  def location
    [city, zip_code, country].compact.join(', ')
  end

  def email_downcase
    email = email.strip.downcase if email
  end

  def capitalize_name
    first_name = first_name.capitalize if first_name
    last_name = last_name.capitalize if last_name
  end

  def password_complexity
    if !password.nil? && password !~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/
      errors.add :password, 'Password must include at least one lowercase letter, one uppercase letter, and one digit'
    end
  end

  def matched_job
    if self.need_us_permit
      Job.remote_or_office_jobs(remote).match_skills_type(skills_array).can_sponsor
    else
      Job.remote_or_office_jobs(remote).match_skills_type(skills_array)
    end
  end


  def self.check_for_first_matches
    self.all.each do |developer|
      developer.matched_job.each do |job|
       Match.create(developer_id: developer.id, job_id: job.id)
      end
    end
  end


  def self.check_for_new_matches
    string = ""
    self.all.each do |developer|
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
