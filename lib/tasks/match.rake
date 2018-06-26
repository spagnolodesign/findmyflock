namespace :match do
  desc "TODO"
  task notification: :environment do
    t = Time.now
    if t.saturday?
      ## RUNNING ONLY IN WEEKENDS
    end
    Developer.check_for_new_matches
  end

end
