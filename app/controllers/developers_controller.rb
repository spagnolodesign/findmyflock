class DevelopersController < ApplicationController

  def edit
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





  # GET /admin/developers
  # GET /admin/developers.json
  def index
    @developers = Developer.all
  end

  # GET /admin/developers/1
  # GET /admin/developers/1.json
  def show
    @job_matches = @developer.matched_job
  end

  # GET /admin/developers/new
  def new
    @developer = Developer.new
  end

  # GET /admin/developers/1/edit
  def edit
  end

  # POST /admin/developers
  # POST /admin/developers.json
  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.html { redirect_to admin_developers_path, notice: 'Developer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/developers/1
  # PATCH/PUT /admin/developers/1.json
  def update
    respond_to do |format|
      if @developer.update(developer_params)
        format.html { redirect_to admin_developer_path(@developer), notice: 'Developer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/developers/1
  # DELETE /admin/developers/1.json
  def destroy
    @developer.destroy
    respond_to do |format|
      format.html { redirect_to admin_developers_url, notice: 'Developer was successfully destroyed.' }
    end
  end
