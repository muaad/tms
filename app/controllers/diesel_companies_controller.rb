class DieselCompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diesel_company, only: [:show, :edit, :update, :destroy]

  # GET /diesel_companies
  # GET /diesel_companies.json
  def index
    @diesel_companies = DieselCompany.all
  end

  # GET /diesel_companies/1
  # GET /diesel_companies/1.json
  def show
  end

  # GET /diesel_companies/new
  def new
    @diesel_company = DieselCompany.new
  end

  # GET /diesel_companies/1/edit
  def edit
  end

  # POST /diesel_companies
  # POST /diesel_companies.json
  def create
    @diesel_company = DieselCompany.new(diesel_company_params)

    respond_to do |format|
      if @diesel_company.save
        format.html { redirect_to new_diesel_company_path, notice: 'Diesel company was successfully created.' }
        format.json { render :show, status: :created, location: @diesel_company }
      else
        format.html { render :new }
        format.json { render json: @diesel_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diesel_companies/1
  # PATCH/PUT /diesel_companies/1.json
  def update
    respond_to do |format|
      if @diesel_company.update(diesel_company_params)
        format.html { redirect_to diesel_companies_path, notice: 'Diesel company was successfully updated.' }
        format.json { render :show, status: :ok, location: @diesel_company }
      else
        format.html { render :edit }
        format.json { render json: @diesel_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diesel_companies/1
  # DELETE /diesel_companies/1.json
  def destroy
    @diesel_company.destroy
    respond_to do |format|
      format.html { redirect_to diesel_companies_url, notice: 'Diesel company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_diesel_companies].split(',').each do |id|
      DieselCompany.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to diesel_companies_path, notice: "You have deleted #{deleted} diesel companies."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diesel_company
      @diesel_company = DieselCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diesel_company_params
      params.require(:diesel_company).permit(:name, :price)
    end
end
