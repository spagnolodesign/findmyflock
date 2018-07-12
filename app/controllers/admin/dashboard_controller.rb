class Admin::DashboardController < Admin::BaseController
  def index
    @developers_count = Developer.all.count
    @companies_count = Company.all.count
    @jobs = Job.all
    @applications = Application.all
    @members = Subscriber.all
  end
end
