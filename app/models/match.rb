class Match < ApplicationRecord
  belongs_to :developer
  belongs_to :job
  has_one :application, dependent: :destroy
  validates_uniqueness_of :developer_id, :scope => :job_id
  validate :match_is_valid?

  def match_is_valid?
    if !developer.matched_job.include?(job)
      errors.add :match, 'No match between developer requirement and job requirement. Impossible to save match'
    end
  end


end
