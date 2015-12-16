class ReportsController < ApplicationController
  def accounts
    @query = ''
    if !params[:truck].blank?
      @truck_query = "truck_id = #{params[:truck]}"
    end

    if !params[:from].blank? && !params[:to].blank?
      from = Date.strptime params[:from], "%m/%d/%Y"
      to = Date.strptime params[:to], "%m/%d/%Y"
      @date_query = "date between #{from} and #{to}"
    end
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

  def cash_in
  end

  def cash_out
  end
end
