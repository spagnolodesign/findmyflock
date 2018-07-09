class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :recruiters, dependent: :nullify
  has_many_attached :images
  has_one :subscriber, -> { order created_at: :desc }, dependent: :destroy

  validates :name, :url, presence: true,  length: { maximum: 500 }

  def applications
    job_ids = jobs.pluck(:id)
    matches_ids = Match.where(job_id: job_ids).pluck(:id)
    Application.where(match_id: matches_ids)
  end

  def recruiters_mail
    self.recruiters.pluck(:email).flatten.uniq
  end

  def is_member?
    !subscriber.nil? && (subscriber.active? || (subscriber.canceled? && subscriber.subscription_expires_at >= Date.today) || subscriber.trialing?)
  end

  def is_allowed_member
    is_member? && (subscriber.plan.stripe_id == "1-job" && jobs.count < 1) ||
    is_member? && (subscriber.plan.stripe_id == "3-jobs" && jobs.count < 3) ||
    vetted?
  end

end
