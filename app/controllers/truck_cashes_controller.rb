class TruckCashesController < ApplicationController
  before_action :set_truck_cash, only: [:show, :edit, :update, :destroy]

  # GET /truck_cashes
  # GET /truck_cashes.json
  def index
    @truck_cashes = TruckCash.all
  end

  # GET /truck_cashes/1
  # GET /truck_cashes/1.json
  def show
  end

  # GET /truck_cashes/new
  def new
    @truck_cash = TruckCash.new
  end

  # GET /truck_cashes/1/edit
  def edit
  end

  # POST /truck_cashes
  # POST /truck_cashes.json
  def create
    date = Date.strptime truck_cash_params[:date], "%m/%d/%Y"
    @truck_cash = TruckCash.new(truck_cash_params)
    @truck_cash.date = date

    respond_to do |format|
      if @truck_cash.save
        format.html { redirect_to truck_path(@truck_cash.truck), notice: 'Truck cash was successfully created.' }
        format.json { render :show, status: :created, location: @truck_cash }
      else
        format.html { render :new }
        format.json { render json: @truck_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /truck_cashes/1
  # PATCH/PUT /truck_cashes/1.json
  def update
    respond_to do |format|
      if @truck_cash.update(truck_cash_params)
        format.html { redirect_to @truck_cash, notice: 'Truck cash was successfully updated.' }
        format.json { render :show, status: :ok, location: @truck_cash }
      else
        format.html { render :edit }
        format.json { render json: @truck_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /truck_cashes/1
  # DELETE /truck_cashes/1.json
  def destroy
    @truck_cash.destroy
    respond_to do |format|
      format.html { redirect_to truck_cashes_url, notice: 'Truck cash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_truck_cash
      @truck_cash = TruckCash.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def truck_cash_params
      params.require(:truck_cash).permit(:truck_id, :amount, :date, :lpo, :description, :direction, :currency)
    end
end
