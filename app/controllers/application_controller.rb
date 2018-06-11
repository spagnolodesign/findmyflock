class ApplicationController < ActionController::Base


protected

  def after_sign_in_path_for(resource)
   if resource.class == Admin
     request.env['omniauth.origin'] || stored_location_for(resource) || admin_dashboard_index
   elsif resource.class == Recruiter && resource.company.nil?
     new_company_path
   elsif resource.class == Recruiter
     dashboard_companies_path
   elsif resource.class == Developer
     edit_profile_developers_path
   else
     dashboard_developers_path
   end
   # request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end
