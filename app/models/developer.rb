class Developer < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications
  has_many :companies , through: :applications
  geocoded_by :location

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_validation :email_downcase
  before_validation :capitalize_name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :password_complexity
  validates :email, :password, presence: true
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }, on: :update
  validates :city, :zip_code, :country, presence: true,  length: { maximum: 100 }
  validates :skills, presence: true, length: { minimum: 1, maximum: 3 }
  validates :min_salary, numericality: { only_integer: true, greater_than: 0}, on: :update
  validates :level, presence: true,  inclusion: { in: 1..5 }, on: :update
  validates :remote, inclusion: { in: [["remote"], ["office"], ["remote", "office"]]}, on: :update

  validates :level, presence: true,  inclusion: { in: 1..5 }, on: :update
  before_save :geocode
  before_save :developer_skills_array


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
      errors.add :password, 'must include at least one lowercase letter, one uppercase letter, and one digit'
    end
  end


  def match
    if self.remote == ["office"]
      Job.only_office_jobs.match_skills_type(self.skills_array)
    elsif self.remote == ["remote"]
      Job.only_remote_jobs.match_skills_type(self.skills_array)
    else
      Job.remote_or_office_jobs.match_skills_type(self.skills_array)
    end
  end

private

  def developer_skills_array
  if skills_changed?
    skills.each do |key, value|
      x = value.to_i
      (value.to_i).times do
        skills_array << "#{key}/#{x}"
        x -= 1
      end
    end
  end
end

end
