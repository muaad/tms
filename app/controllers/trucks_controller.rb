class TrucksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_truck, only: [:show, :edit, :update, :destroy]

  # GET /trucks
  # GET /trucks.json
  def index
    if !params[:owner].blank?
      @trucks = Truck.where(truck_owner: params[:owner])
    else
      @trucks = Truck.all
    end
  end

  # GET /trucks/1
  # GET /trucks/1.json
  def show
  end

  # GET /trucks/new
  def new
    @truck = Truck.new
  end

  # GET /trucks/1/edit
  def edit
  end

  # POST /trucks
  # POST /trucks.json
  def create
    @truck = Truck.new(truck_params)

    driver = Driver.find_by id_number: params[:driver_id_number]
    turn_boy = TurnBoy.find_by id_number: params[:turn_boy_id_number]
    owner = TruckOwner.find_by id_number: params[:owner_id_number]

    if driver.nil?
      driver = Driver.create! id_number: params[:driver_id_number], phone_number: params[:driver_phone_number], name: params[:driver_name], address: params[:driver_address]
    end

    if turn_boy.nil?
      turn_boy = TurnBoy.create! id_number: params[:turnboy_id_number], phone_number: params[:turnboy_phone_number], name: params[:turnboy_name], address: params[:turnboy_address]
    end

    if owner.nil?
      owner = TruckOwner.create! id_number: params[:owner_id_number], phone_number: params[:owner_phone_number], name: params[:owner_name], address: params[:owner_address], entity_type: params[:owner_type]
    end

    @truck.truck_owner = owner

    respond_to do |format|
      if @truck.save
        truck_driver = TruckDriver.find_or_create_by! driver: driver, truck: @truck
        truck_driver.update(active: true, salary: params[:driver_salary])
        truck_turn_boy = TruckTurnBoy.find_or_create_by! turn_boy: turn_boy, truck: @truck
        truck_turn_boy.update(active: true, salary: params[:turn_boy_salary])
        format.html { redirect_to @truck, notice: 'Truck was successfully created.' }
        format.json { render :show, status: :created, location: @truck }
      else
        format.html { render :new }
        format.json { render json: @truck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trucks/1
  # PATCH/PUT /trucks/1.json
  def update
    respond_to do |format|
      if @truck.update(truck_params)
        format.html { redirect_to @truck, notice: 'Truck was successfully updated.' }
        format.json { render :show, status: :ok, location: @truck }
      else
        format.html { render :edit }
        format.json { render json: @truck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trucks/1
  # DELETE /trucks/1.json
  def destroy
    @truck.destroy
    respond_to do |format|
      format.html { redirect_to trucks_url, notice: 'Truck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_trucks].split(',').each do |id|
      Truck.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to trucks_path, notice: "You have deleted #{deleted} trucks."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_truck
      @truck = Truck.find(params[:id])
      @truck.driver_salary = @truck.calculate_driver_salary
      @truck.turn_boy_salary = @truck.calculate_turn_boy_salary
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def truck_params
      params.require(:truck).permit(:registration_number)
    end
end
