class DevelopersController < ApplicationController
  before_action :authenticate_developer!, only: [:edit_profile, :add_skills, :update, :dashboard]


  def show
    @developer = Developer.find(params[:id])
  end

  def edit_profile
    @developer = current_developer
  end

  def add_skills
    @developer = current_developer
  end

  def update
    @developer = current_developer
    @developer.update(developer_params)
    @developer.set_url
    @developer.first_login = true
    if @developer.save
      redirect_to add_skills_developers_path
    else
      render action: 'edit_profile'
    end
  end


  def dashboard
    @developer = current_developer
    @skills = @developer.skills
  end

  private

  def developer_params
    params.require(:developer).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar, :min_salary, :need_us_permit, :city, :zip_code, :mobility, :state, :country, :linkedin_url, :github_url, :full_mobility, remote:[], resumes: [])
  end
end
