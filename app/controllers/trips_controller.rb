class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    if !params[:truck].blank?
      @trips = Trip.where(truck_id: params[:truck])
    else
      @trips = Trip.all
    end
    if !params[:currency].blank?
      @trips = @trips.where(currency: params[:currency])
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
    @expense = Expense.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        if !trip_params[:mileage].blank?
          if @trip.currency == "US Dollar"
            amount = ExchangeRate.first.rate * @trip.mileage
          else
            amount = @trip.mileage
          end
          category = ExpenseCategory.find_or_create_by name: "Mileage"
          Expense.create! lpo: params[:mileage_lpo], amount: amount, truck: @trip.truck, currency: @trip.currency, trip: @trip, expense_category: category, date: @trip.date, description: @trip.description
        end
        category = ExpenseCategory.find_or_create_by name: "Diesel"
        xp = Expense.create! lpo: params[:diesel_lpo], amount: params[:diesel_amount], truck: @trip.truck, currency: @trip.currency, trip: @trip, expense_category: category, date: @trip.date, description: @trip.description, quantity: params[:diesel_litres]
        company = DieselCompany.find(params[:diesel_company])
        DieselExpense.create! expense: xp, diesel_company: company, litres: xp.quantity
        format.html { redirect_to trips_path, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trips_path, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_trips].split(',').each do |id|
      Trip.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to trips_path, notice: "You have deleted #{deleted} trips."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:truck_id, :driver_id, :turn_boy_id, :date, :depot_id, :destination_id, :consignee_id, :product_id, :quantity, :rate, :amount, :commission, :short, :description, :currency, :mileage)
    end
end
