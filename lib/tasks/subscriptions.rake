namespace :subscriptions do
  desc "Deactive jobs from un-paid customers"
  task deactive_jobs: :environment do
    Company.all.each do |company|
      if !company.is_member?
        p "#{company.name} not anymore a member"
        company.jobs.update_all(active: false)
      end
    end
  end
end
