SKILLS = ["AR", "VR", "Cybersecurity", "Management", "Kubernetes", "Docker", "Architecture", "Mentorship", "AWS", "Java", "Python", "C", "Ruby", "Javascript", "JQuery", "AngularJS", "Node.js", "React", "PHP", "WordPress", "HTML", "CSS", "Objective-C", "Swift", "iOS", "Android", "Kotlin", "SQL", ".NET", "R", "Perl", "MATLAB", "Erlang", "Scala", "Bash", "Clojure", "Haskell", "Groovy", "DevOps", "Systems", "Apex", "SAS", "Crystal", "git", "GitHub", "Project Management", "Product Management", "Engineering Management", "CTO", "User Experience Design / UX", "User Interface Design / UI", "Quality Assurance / QA", "Automated QA", "Ruby on Rails", "SaaS", "React Native", "Technical Sales", "Outbound Sales", "Business Development", "Training", "Django"]

EMPLOYMENT_TYPE= ["full-time", "part-time", "contract", "temporary", "seasonal", "internship"]


BENEFITS = ["Office Dogs", "Equity", "Remote", "30+ Days Parental Leave", "60+ Days Parental Leave", "90+ Days Parental Leave", "Flexible Hours", "Social Mission", "Environmental Mission", "401(k)", "401(k) Matching", "100\% Covered Health Insurance", "80\%+ Covered Health Insurance", "Dental Insurance", "Vision Insurance", "Life Insurance", "Trans-Inclusive Healthcare", "Professional Development Budget", "Unlimited Vacation", "30+ Days Vacation", "Lunch Provided", "Beach Within 60 Minutes", "Mountain Within 60 Minutes", "In-Office Gym", "Flat Heirarchy", "Commuter Coverage"]

CULTURES = ["family-like team" "Cubicles," "No cubicles," "company outings," "beer on tap", "ping pong", "Game Nights", "pair programming", "not pair programming"]

SKILLS.each do |skill|
  Skill.create(value: skill)
end

BENEFITS.each do |value|
  Benefit.create(value: value)
end

CULTURES.each do |value|
  Culture.create(value: value)
end


10.times do
  company = Company.create(url:Faker::Internet.url, name: Faker::Company.name)
  puts "created company #{company}"
end

  Company.all.each do |company|
    rand(1..4).times do
      cultures = []
      benefits = []
      skills = []
      remote = [["remote"], ["office"], ["remote", "office"]]
      salary = [10000, 20000, 30000, 40000, 50000, 60000]
      rand(2..5).times do
        cultures << Culture.find(rand(1..Culture.count)).value
      end
      rand(2..5).times do
        benefits << Benefit.find(rand(1..Benefit.count)).value
      end
      rand(2..5).times do
        skills << Skill.find(rand(1..Skill.count)).value
      end
      job = Job.new(
          title: Faker::FamilyGuy.character ,
          description: Faker::Lorem.paragraph(2, false, 4),
          remote: remote.sample,
          city: "Los Angeles",
          zip_code: "90009",
          state: "California",
          country: "United States",
          employment_type: EMPLOYMENT_TYPE.sample,
          level: rand(1..5),
          latitude: nil,
          longitude: nil,
          max_salary: salary.sample,
          skills: skills,
          benefits: benefits,
          cultures: cultures,
          can_sponsor: Faker::Boolean.boolean(0.2),
          company: Company.find(1)
      )
      job.save

      puts "created job #{job}"
    end
end
