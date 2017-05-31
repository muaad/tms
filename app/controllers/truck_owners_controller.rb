class TruckOwnersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_truck_owner, only: [:show, :edit, :update, :destroy]

  # GET /truck_owners
  # GET /truck_owners.json
  def index
    if !params[:type].blank?
      @truck_owners = TruckOwner.where(entity_type: params[:type])
    else
      @truck_owners = TruckOwner.all
    end
  end

  # GET /truck_owners/1
  # GET /truck_owners/1.json
  def show
  end

  # GET /truck_owners/new
  def new
    @truck_owner = TruckOwner.new
  end

  # GET /truck_owners/1/edit
  def edit
  end

  # POST /truck_owners
  # POST /truck_owners.json
  def create
    @truck_owner = TruckOwner.new(truck_owner_params)

    respond_to do |format|
      if @truck_owner.save
        format.html { redirect_to new_truck_owner_path, notice: 'Truck owner was successfully created.' }
        format.json { render :show, status: :created, location: @truck_owner }
      else
        format.html { render :new }
        format.json { render json: @truck_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /truck_owners/1
  # PATCH/PUT /truck_owners/1.json
  def update
    respond_to do |format|
      if @truck_owner.update(truck_owner_params)
        format.html { redirect_to truck_owners_path, notice: 'Truck owner was successfully updated.' }
        format.json { render :show, status: :ok, location: @truck_owner }
      else
        format.html { render :edit }
        format.json { render json: @truck_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /truck_owners/1
  # DELETE /truck_owners/1.json
  def destroy
    @truck_owner.destroy
    respond_to do |format|
      format.html { redirect_to truck_owners_url, notice: 'Truck owner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_trucks].split(',').each do |id|
      TruckOwner.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to trucks_path, notice: "You have deleted #{deleted} trucks."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_truck_owner
      @truck_owner = TruckOwner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def truck_owner_params
      params.require(:truck_owner).permit(:name, :phone_number, :address, :id_number, :entity_type)
    end
end
