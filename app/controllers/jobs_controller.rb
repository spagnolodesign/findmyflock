class JobsController < ApplicationController
  before_action :authenticate_recruiter!
  before_action :set_job, only: [:show, :edit, :update, :skills]

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.company = current_recruiter.company

    respond_to do |format|
      if @job.save
        format.html { redirect_to dashboard_companies_path, notice: 'Job was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to dashboard_companies_path, notice: 'Job was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def skills
  end

  private

  def set_job
    @job = Job.all.find(params[:id])
    if !current_recruiter.company.jobs.include?(@job)
      redirect_to dashboard_companies_path, notice: 'Not authorized.'
    end
  end

  def job_params
    params.require(:job).permit(:title, :description, :city, :zip_code, :state, :country, :max_salary, :employment_type, :can_sponsor, :active, remote:[], benefits:[], cultures:[])
  end
end
