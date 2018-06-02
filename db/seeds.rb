SKILLS = ['AR', 'VR', 'Cybersecurity', 'Management', 'Kubernetes', 'Docker', 'Architecture', 'Mentorship', 'AWS', 'Java', 'Python', 'C', 'Ruby', 'Javascript', 'JQuery', 'AngularJS', 'Node.js', 'React', 'PHP', 'WordPress', 'HTML', 'CSS', 'Objective-C', 'Swift', 'iOS', 'Android', 'Kotlin', 'SQL', '.NET', 'R', 'Perl', 'MATLAB', 'Erlang', 'Scala', 'Bash', 'Clojure', 'Haskell', 'Groovy', 'DevOps', 'Systems', 'Apex', 'SAS', 'Crystal', 'git', 'GitHub', 'Project Management', 'Product Management', 'Engineering Management', 'CTO', 'User Experience Design / UX', 'User Interface Design / UI', 'Quality Assurance / QA', 'Automated QA', 'Ruby on Rails', 'SaaS', 'React Native', 'Technical Sales', 'Outbound Sales', 'Business Development', 'Training', 'Django'].freeze

EMPLOYMENT_TYPE = ['full-time', 'part-time', 'contract', 'temporary', 'seasonal', 'internship'].freeze

BENEFITS = ['Office Dogs', 'Equity', 'Remote', '30+ Days Parental Leave', '60+ Days Parental Leave', '90+ Days Parental Leave', 'Flexible Hours', 'Social Mission', 'Environmental Mission', '401(k)', '401(k) Matching', "100\% Covered Health Insurance", "80\%+ Covered Health Insurance", 'Dental Insurance', 'Vision Insurance', 'Life Insurance', 'Trans-Inclusive Healthcare', 'Professional Development Budget', 'Unlimited Vacation', '30+ Days Vacation', 'Lunch Provided', 'Beach Within 60 Minutes', 'Mountain Within 60 Minutes', 'In-Office Gym', 'Flat Heirarchy', 'Commuter Coverage'].freeze

CULTURES = ['family-like team', 'Cubicles', 'No cubicles' , 'company outings' , 'beer on tap', 'ping pong', 'Game Nights', 'pair programming', 'not pair programming'].freeze

SKILLS.each do |skill|
  Skill.create(value: skill)
end

p "Created #{Skill.all.count} skills"

BENEFITS.each do |value|
  Benefit.create(value: value)
end

p "Created #{Benefit.all.count} benefits"


CULTURES.each do |value|
  Culture.create(value: value)
end

p "Created #{Culture.all.count} cultures"


10.times do
  company = Company.create(url: Faker::Internet.url, name: Faker::Company.name)
  puts "created company #{company.name}"
end

Company.all.each do |company|
  30.times do
    cultures = []
    benefits = []
    skills = []
    remote = [['remote'], ['office'], %w[remote office]]
    salary = [10_000, 20_000, 30_000, 40_000, 50_000, 60_000]
    rand(2..5).times do
      cultures << Culture.find(rand(1..Culture.count)).value
    end
    rand(2..5).times do
      benefits << Benefit.find(rand(1..Benefit.count)).value
    end
    rand(1..2).times do
      skills << Skill.find(rand(1..Skill.count)).value
    end
    job = Job.new(
      title: Faker::FamilyGuy.character,
      description: Faker::Lorem.paragraph(2, false, 4),
      remote: remote.sample,
      city: 'Los Angeles',
      zip_code: '90009',
      state: 'California',
      country: 'United States',
      employment_type: EMPLOYMENT_TYPE.sample,
      level: rand(1..5),
      latitude: nil,
      longitude: nil,
      max_salary: salary.sample,
      benefits: benefits,
      cultures: cultures,
      can_sponsor: Faker::Boolean.boolean(0.2),
      company: company
    )

    rand(1..2).times do
      job.skills[SKILLS.sample] = rand(1..4)
    end
    job.save
    puts "created job #{job.title}"

  end

end
#
p "Creating Developer"

40.times do

  skills = []
    rand(2..5).times do
      skills << Skill.find(rand(1..Skill.count)).value
    end
    dev = Developer.create(
    email: Faker::Internet.email,
    password: 'Developer1!',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: 'Los Angeles',
    zip_code: '90009',
    country: 'United States',
    need_us_permit: Faker::Boolean.boolean(0.2),
    min_salary: salary = [10_000, 20_000, 30_000].sample,
    level: rand(1..5),
    remote: [['remote'], ['office'], %w[remote office]].sample,
  )
  3.times do
    dev.skills[SKILLS.sample] = rand(2..5)
  end

  dev.save
 p "One developer created"
end
#
