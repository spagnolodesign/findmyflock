class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :recruiters, dependent: :nullify
  has_many_attached :images
  validates :name, :url, presence: true,  length: { maximum: 500 }


  ## Refactor this method possible error in schema relation?
  def applications
    job_ids = jobs.pluck(:id)
    matches_ids = Match.where(job_id: job_ids).pluck(:id)
    Application.where(match_id: matches_ids)
  end

  def recruiters_mail
    self.recruiters.pluck(:email).flatten.uniq
  end
