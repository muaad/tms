class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy, :edit_diesel_expense]

  # GET /expenses
  # GET /expenses.json
  def index
    if !params[:category].blank?
      if params[:category] == '0'
        redirect_to "#{new_expense_category_path}?name=Diesel"
      else
        @expenses = Expense.where(expense_category_id: params[:category])
      end
    elsif !params[:truck].blank?
      @expenses = Expense.where(truck_id: params[:truck])
    else
      @expenses = Expense.all
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  def new_diesel_expense
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
    if @expense.category.name == "Diesel"
      redirect_to edit_diesel_expense_path(@expense)
    end
  end

  def edit_diesel_expense
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        if !params[:expense_category].blank?
          category = ExpenseCategory.find_by name: params[:expense_category]
          if !category.nil?
            @expense.update(expense_category: category)
            if params[:expense_category] == "Diesel"
              company = DieselCompany.find(params[:diesel_company])
              DieselExpense.create! expense: @expense, diesel_company: company, litres: @expense.quantity
            end
          end
        end
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_expenses].split(',').each do |id|
      Expense.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to expenses_path, notice: "You have deleted #{deleted} expenses."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:expense_category_id, :amount, :product_id, :driver_id, :truck_id, :turn_boy_id, :user_id, :description, :lpo, :date, :trip_id, :quantity, :unit_price)
    end
end
