class CompanyMailer < ApplicationMailer
  default :from => 'job@findmyflock.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address

  def welcome_company(company)
    @company = company
    mail(:from =>  'welcome@findmyflock.com',
      :to =>   company.recruiters.first.email,
    :subject => 'Welcome on Findmyflock!' )
  end
  def new_application_advise(addresses, match, developer)
      @developer = developer
      @job = match.job
      @application = match.application
      mail( :to => addresses,
      :subject => 'New applications for your job!' )
  end

  def contact_developer(message, application, job, developer, address)
      @message = message
      @developer = developer
      @job = job
      @application = application
      mail(
        :from =>address,
        :to => @developer.email,
        :subject => "A new message from #{@job.company.name} for your job application" )
  end


end
