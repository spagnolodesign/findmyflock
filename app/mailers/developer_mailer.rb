class DeveloperMailer < ApplicationMailer
  default :from => 'job@findmyflock.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def new_match_advise(developer, jobs)
    @developer = developer
    @jobs = jobs
    mail( :to => @developer.email,
    :subject => 'You have new matches!' )
  end
end
