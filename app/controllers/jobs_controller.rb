class JobsController < ApplicationController

  def new
    @job = Job.new
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


  private

  def set_job
    @job = Job.all.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :city, :zip_code, :state, :country, :max_salary, :employment_type, :can_sponsor, remote:[], benefits:[], cultures:[])
  end
end
