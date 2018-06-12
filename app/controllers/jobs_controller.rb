class JobsController < ApplicationController
  before_action :authenticate_recruiter!
  before_action :set_job, only: [:show, :edit, :update, :skills, :benefits]

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.company = current_recruiter.company

    step = params[:job][:navigate_to]
    respond_to do |format|
      if @job.save
        if step == "skills"
          format.html { redirect_to skills_job_path(@job) }
        elsif step == "dashboard"
          format.html { redirect_to dashboard_companies_path }
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    step = params[:job][:navigate_to]

    respond_to do |format|
      if @job.update(job_params)
        if step == "skills"
          format.html { redirect_to skills_job_path(@job) }
        elsif step == "dashboard"
          format.html { redirect_to dashboard_companies_path }
        end
      else
        format.html { render :edit }
      end
    end
  end

  def skills
  end

  def benefits
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
