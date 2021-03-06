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
    session[:index] = 1
  end

  # GET /trips/1/edit
  def edit
    session[:index] = @trip.diesel_expenses.last.try(:id)
  end

  # POST /trips
  # POST /trips.json
  def create
    date = Date.strptime trip_params[:date], "%m/%d/%Y"
    @trip = Trip.new(trip_params)
    @trip.date = date

    respond_to do |format|
      if @trip.save
        if !params[:exchange_rate].blank?
          if ExchangeRate.first.nil?
            ExchangeRate.create(rate: params[:exchange_rate])
          else
            ExchangeRate.first.update(rate: params[:exchange_rate])
          end
        end
        if !trip_params[:mileage].blank?
          # if @trip.currency == "US Dollar"
          #   amount = ExchangeRate.first.rate * @trip.mileage
          # else
          #   amount = @trip.mileage
          # end
          category = ExpenseCategory.find_or_create_by name: "Mileage"
          xp = Expense.create! lpo: params[:mileage_lpo], amount: @trip.mileage, truck: @trip.truck, currency: 'Kenya Shilling', trip: @trip, expense_category: category, date: @trip.date, description: @trip.description
          if @trip.currency == "US Dollar"
            xp.update(dollar_amount: @trip.mileage / ExchangeRate.first.rate)
          end
        end
        category = ExpenseCategory.find_or_create_by name: "Diesel"

        params[:diesel_expense].values.each do |dx|
          xp = Expense.create! lpo: dx[:diesel_lpo], amount: dx[:diesel_amount], truck: @trip.truck, currency: 'Kenya Shilling', trip: @trip, expense_category: category, date: @trip.date, description: @trip.description, quantity: dx[:diesel_litres], unit_price: dx[:diesel_price]
          company = DieselCompany.find(dx[:diesel_company])
          company.update(price: dx[:diesel_price])
          DieselExpense.create! expense: xp, diesel_company: company, litres: xp.quantity
          if xp.currency == "US Dollar"
            xp.update(dollar_amount: (xp.amount / ExchangeRate.first.rate))
          end
        end

        # xp = Expense.create! lpo: params[:two_diesel_lpo], amount: params[:two_diesel_amount], truck: @trip.truck, currency: @trip.currency, trip: @trip, expense_category: category, date: @trip.date, description: @trip.description, quantity: params[:two_diesel_litres]
        # company = DieselCompany.find(params[:two_diesel_company])
        # DieselExpense.create! expense: xp, diesel_company: company, litres: xp.quantity
        # if xp.currency == "US Dollar"
        #   xp.update(dollar_amount: (xp.amount / ExchangeRate.first.rate))
        # end

        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def diesel_expense
    session[:index] = session[:index].to_i + 1
    render partial: 'trips/diesel_expense', locals: {index: session[:index], first: false, diesel_expense: nil, new_record: true}
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        if !params[:exchange_rate].blank?
          if ExchangeRate.first.nil?
            ExchangeRate.create(rate: params[:exchange_rate])
          else
            ExchangeRate.first.update(rate: params[:exchange_rate])
          end
        end
        if !trip_params[:mileage].blank?
          category = ExpenseCategory.find_or_create_by name: "Mileage"
          xp = @trip.mileage_expense
          if !xp.nil?
            xp.update(lpo: params[:mileage_lpo], amount: @trip.mileage, truck: @trip.truck, date: @trip.date, description: @trip.description)
          else
            xp = Expense.create! lpo: params[:mileage_lpo], amount: @trip.mileage, truck: @trip.truck, currency: 'Kenya Shilling', trip: @trip, expense_category: category, date: @trip.date, description: @trip.description
          end
          if @trip.currency == "US Dollar"
            xp.update(dollar_amount: @trip.mileage / ExchangeRate.first.rate)
          end
        end
        category = ExpenseCategory.find_or_create_by name: "Diesel"

        params[:diesel_expense].each do |k, v|
          id = k.gsub('item_', '')
          dx = DieselExpense.find_by(id: id)
          if dx.nil?
            xp = Expense.create! lpo: v[:diesel_lpo], amount: v[:diesel_amount], truck: @trip.truck, currency: 'Kenya Shilling', trip: @trip, expense_category: category, date: @trip.date, description: @trip.description, quantity: v[:diesel_litres], unit_price: v[:diesel_price]
            company = DieselCompany.find(v[:diesel_company])
            company.update(price: v[:diesel_price])
            DieselExpense.create! expense: xp, diesel_company: company, litres: xp.quantity
            if xp.currency == "US Dollar"
              xp.update(dollar_amount: (xp.amount / ExchangeRate.first.rate))
            end
          else
            company = DieselCompany.find(v[:diesel_company])
            company.update(price: v[:diesel_price])
            dx.update(diesel_company: company, litres: xp.quantity)
            xp = dx.expense
            xp.update(lpo: v[:diesel_lpo], amount: v[:diesel_amount], truck: @trip.truck, expense_category: category, date: @trip.date, description: @trip.description, quantity: v[:diesel_litres], unit_price: v[:diesel_price])
            if xp.currency == "US Dollar"
              xp.update(dollar_amount: (xp.amount / ExchangeRate.first.rate))
            end
          end
        end
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
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
