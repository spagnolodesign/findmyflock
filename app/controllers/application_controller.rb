class ApplicationController < ActionController::Base


protected

  def after_sign_in_path_for(resource)
    byebug
   if resource.class == Recruiter && resource.company.nil?
     new_company_path
   elsif resource.class == Recruiter
     dashboard_companies_path
   elsif resource.class == Developer && !resource.first_login
     edit_profile_developers_path
   else
     dashboard_developers_path
   end
  end
end
