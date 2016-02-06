class CashesController < ApplicationController
  before_action :set_cash, only: [:show, :edit, :update, :destroy]

  # GET /cashes
  # GET /cashes.json
  def index
    @cashes = Cash.all
    @cash = Cash.new
  end

  # GET /cashes/1
  # GET /cashes/1.json
  def show
  end

  # GET /cashes/new
  def new
    @cash = Cash.new
  end

  # GET /cashes/1/edit
  def edit
  end

  # POST /cashes
  # POST /cashes.json
  def create
    @cash = Cash.new(cash_params)
    @cash.balance = Cash.sum(:amount_in) - Expense.sum(:amount)
    if !cash_params[:date].blank?
      date = Date.strptime cash_params[:date], "%m/%d/%Y"
      @cash.date = date
    end

    respond_to do |format|
      if @cash.save
        format.html { redirect_to cashes_path, notice: 'Cash was successfully added.' }
        format.json { render :show, status: :created, location: @cash }
      else
        format.html { render :new }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cashes/1
  # PATCH/PUT /cashes/1.json
  def update
    respond_to do |format|
      if @cash.update(cash_params)
        @cash.total_cash = Cash.total
        @cash.balance = Cash.sum(:amount_in) - Expense.sum(:amount)
        format.html { redirect_to cashes_path, notice: 'Cash was successfully updated.' }
        format.json { render :show, status: :ok, location: @cash }
      else
        format.html { render :edit }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cashes/1
  # DELETE /cashes/1.json
  def destroy
    @cash.destroy
    respond_to do |format|
      format.html { redirect_to cashes_url, notice: 'Cash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash
      @cash = Cash.find(params[:id])
      @cash.total_cash = Cash.total
      @cash.balance = Cash.sum(:amount_in) - Expense.sum(:amount)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cash_params
      params.require(:cash).permit(:date, :amount_in, :amount_out, :balance, :closed, :lpo, :description)
    end
end
