class Skill < ApplicationRecord
  after_save :generate_skills_array
  # validates :name, :uniqueness => { :scope => [:skillable_type , :skillable_id] }


  def generate_skills_array
    if skillable_type == 'Job'
      @job = Job.find(skillable_id)
      @job.skills_array.clear
      @job.skills.pluck(:name, :level).each do |skill|
        @job.skills_array << "#{skill[0]}/#{skill[1]}"
        @job.save
      end
    else
      @developer = Developer.find(skillable_id)
      @developer.skills_array.clear
      @developer.skills.pluck(:name, :level).each do |skill|
        x = skill[1].to_i
        skill[1].to_i.times do
          level = x
          @developer.skills_array << "#{skill[0]}/#{level}"
          @developer.save
          x -= 1
        end
      end
    end
  end
end
