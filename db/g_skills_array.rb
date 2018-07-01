# Skill.all.each do |skill|
#   if skill.skillable_type == 'Job'
#     @job = Job.find(skill.skillable_id)
#     p "Select job #{@job.title}"
#     @job.skills_array.clear
#     @job.skills.pluck(:name, :level).each do |skill|
#       @job.skills_array << "#{skill[0]}/#{skill[1]}"
#     end
#     p "Job new array #{@job.skills_array}"
#     @job.save
#   end
# end
