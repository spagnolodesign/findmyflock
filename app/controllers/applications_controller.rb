class ApplicationsController < ApplicationController
  before_action :authenticate_developer!, only:[:new, :create]
  before_action :authenticate_recruiter!, only:[:show, :contact]
  before_action :set_application, only: [:show, :contact]
  before_action :set_job, only: [:new, :create]
  before_action :set_match, only: [:new, :create]

  def show
    DeveloperMailer.application_opened(@application).deliver_later if @application.pending?
    set_opened(@application)
  end

  def new
    @application = Application.new
    set_match
    @is_posted = application_is_posted?(@match)
  end

  def edit
  end

  def create
    @application = Application.new(application_params)
    @application.match = @match
    @developer = @match.developer
    @company = @match.job.company
    @mail_addresses = @company.recruiters_mail.join(",")
    respond_to do |format|
      if @application.save
        format.html { redirect_to new_job_application_path(@match.job), notice: "Yeah, your application is traveling!" }
          CompanyMailer.new_application_advise(@mail_addresses, @match, @developer).deliver_later
      else
        format.html { render :new }
      end
    end
  end

  def contact
    message = params[:private_message]
    if !message.empty?
      @mail_address = current_recruiter.email
      CompanyMailer.contact_developer(message, @application, @job, @developer, @mail_address).deliver_later
      @application.contacted!
      redirect_to job_application_path(@job), notice: "We've sent an email to the candidate."
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_application
    @application = Application.find(params[:id])
    @job = @application.match.job
    @developer = @application.match.developer
  end

  def application_is_posted?(match)
    Application.where(match: match).any?
  end

  def set_match
    @match = Match.where(developer:current_developer, job:@job).first_or_create
    if current_developer.matched_job.include?(@job)
      @match
    else
      redirect_to dashboard_developers_path, notice: "Sorry you can't apply to this job!"
    end
  end

  def set_opened(application)
    if application.pending?
      application.opened!
    end
  end

  def application_params
    params.require(:application).permit(:message)
  end
end
