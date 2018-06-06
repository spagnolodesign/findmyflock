class Admin::CulturesController < Admin::BaseController
  before_action :set_culture, only: [:show, :edit, :update, :destroy]

  # GET /benefits
  # GET /benefits.json
  def index
    @cultures = Culture.all
  end

  # GET /benefits/1
  # GET /benefits/1.json
  def show
  end

  # GET /benefits/new
  def new
    @culture = Culture.new
  end

  # GET /benefits/1/edit
  def edit
  end

  # POST /benefits
  # POST /benefits.json
  def create
    @culture = Culture.new(benefit_params)

    respond_to do |format|
      if @culture.save
        format.html { redirect_to admin_benefits_path, notice: 'Culture was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /benefits/1
  # PATCH/PUT /benefits/1.json
  def update
    respond_to do |format|
      if @culture.update(benefit_params)
        format.html { redirect_to admin_culture_path(@culture), notice: 'Culture was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /benefits/1
  # DELETE /benefits/1.json
  def destroy
    @culture.destroy
    respond_to do |format|
      format.html { redirect_to admin_cultures_url, notice: 'Culture was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_culture
      @culture = Culture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_params
      params.require(:culture).permit(:value)
    end
end
