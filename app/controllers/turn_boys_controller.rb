class TurnBoysController < ApplicationController
  before_action :set_turn_boy, only: [:show, :edit, :update, :destroy]

  # GET /turn_boys
  # GET /turn_boys.json
  def index
    @turn_boys = TurnBoy.all
  end

  # GET /turn_boys/1
  # GET /turn_boys/1.json
  def show
  end

  # GET /turn_boys/new
  def new
    @turn_boy = TurnBoy.new
  end

  # GET /turn_boys/1/edit
  def edit
  end

  # POST /turn_boys
  # POST /turn_boys.json
  def create
    @turn_boy = TurnBoy.new(turn_boy_params)

    respond_to do |format|
      if @turn_boy.save
        format.html { redirect_to @turn_boy, notice: 'Turn boy was successfully created.' }
        format.json { render :show, status: :created, location: @turn_boy }
      else
        format.html { render :new }
        format.json { render json: @turn_boy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turn_boys/1
  # PATCH/PUT /turn_boys/1.json
  def update
    respond_to do |format|
      if @turn_boy.update(turn_boy_params)
        format.html { redirect_to @turn_boy, notice: 'Turn boy was successfully updated.' }
        format.json { render :show, status: :ok, location: @turn_boy }
      else
        format.html { render :edit }
        format.json { render json: @turn_boy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turn_boys/1
  # DELETE /turn_boys/1.json
  def destroy
    @turn_boy.destroy
    respond_to do |format|
      format.html { redirect_to turn_boys_url, notice: 'Turn boy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_turn_boys].split(',').each do |id|
      TurnBoy.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to turn_boys_path, notice: "You have deleted #{deleted} turn boys."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn_boy
      @turn_boy = TurnBoy.find(params[:id])
      if !params[:truck].blank?
        truck = Truck.find(params[:truck])
        salary = @turn_boy.calculate_salary(truck)
        if !salary.blank?
          @turn_boy.salary = salary
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def turn_boy_params
      params.require(:turn_boy).permit(:name, :phone_number, :address, :id_number)
    end
end
