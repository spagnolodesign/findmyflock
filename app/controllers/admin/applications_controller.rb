class Admin::ApplicationsController < Admin::BaseController
  before_action :set_application, only: [:show]

  def index
    @applications = Application.all.order(created_at: :desc)
  end

  def show
    @job = @application.match.job
    @developer = @application.match.developer
  end

  private

  def set_application
    @application = Application.all.find(params[:id])
  end
end
