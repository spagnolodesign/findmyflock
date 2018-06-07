class Admin::SkillsController < Admin::BaseController
  def create
    @developer = Developer.find(params[:developer_id]) if params[:developer_id]
    @job = Job.find(params[:job_id]) if params[:job_id]

    if @developer
      @developer.skills.new(skill_params).save
    else
      @job.skills.new(skill_params).save
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
  end

  def skill_params
    params.require(:skill).permit(:name, :level)
  end
end
