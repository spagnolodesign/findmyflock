class DeveloperMailer < ApplicationMailer
  default :from => 'job@findmyflock.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address

  def welcome_email(developer)
    @email = developer.email
    mail(:from =>  'welcome@findmyflock.com',
      :to =>   @email,
    :subject => 'Welcome on Findmyflock!' )
  end
  def new_match_advise(developer, jobs)
    @developer = developer
    @jobs = jobs
    mail( :to => @developer.email,
    :subject => 'You have new matches!' )
  end

  def application_opened(application)
    @job = application.match.job
    @developer = application.match.developer
    @company = @job.company
    mail( :to => @developer.email,
    :subject => 'Your application has been readed!' )
  end

end
