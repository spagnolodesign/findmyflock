class Admin::CompaniesController < Admin::BaseController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /comapies
  # GET /comapies.json
  def index
    @companies = Company.all
  end

  # GET /comapies/1
  # GET /comapies/1.json
  def show
  end

  # GET /comapies/new
  def new
    @company = Company.new
  end

  # GET /comapies/1/edit
  def edit
  end

  # POST /comapies
  # POST /comapies.json
  def create
    @company = Company.new(benefit_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to admin_comapies_path, notice: 'Company was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comapies/1
  # PATCH/PUT /comapies/1.json
  def update
    respond_to do |format|
      if @company.update(benefit_params)
        format.html { redirect_to admin_company_path(@company), notice: 'Company was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /comapies/1
  # DELETE /comapies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url, notice: 'Company was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_params
      params.require(:company).permit(:name, :url)
    end
end
