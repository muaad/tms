class ReportsController < ApplicationController
  before_action :set_reports, only: [:accounts, :category, :cash, :trips]
  def accounts

  end

  def category
    @category = ExpenseCategory.find(params[:category])
  end

  def trucks
  end

  def trips
  end

  def drivers
  end

  def turn_boys
  end

  def owners
  end

  def cash
  end

  private
    def set_reports
      if !params[:truck].blank?
        @truck_query = "truck_id = #{params[:truck]}"
        @truck_name = Truck.find(params[:truck]).name
        @owner = Truck.find(params[:truck]).owner.name
      end

      if !params[:from].blank? && !params[:to].blank?
        @from = Date.strptime params[:from], "%m/%d/%Y"
        @to = Date.strptime params[:to], "%m/%d/%Y"
      end
    end
end
