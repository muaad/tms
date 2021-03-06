# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  truck_id       :integer
#  driver_id      :integer
#  turn_boy_id    :integer
#  date           :date
#  depot_id       :integer
#  destination_id :integer
#  consignee_id   :integer
#  product_id     :integer
#  quantity       :integer
#  rate           :float
#  amount         :float
#  commission     :float
#  short          :float
#  description    :text
#  currency       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :integer
#  mileage        :float
#

class Trip < ApplicationRecord
  include Reportable

  belongs_to :truck
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :consignee
  belongs_to :product
  # has_many :expenses
  belongs_to :account
  acts_as_tenant(:account)

  def depot
  	City.find(depot_id)
  end

  def destination
  	City.find(destination_id)
  end

  def name
  	"#{truck.registration_number} - #{date} - #{destination.name}"
  end

  def next_trip
    Trip.where("id > ?", id).first
  end

  def prev_trip
    Trip.where("id < ?", id).last
  end

  def expenses
    to_date = truck.expenses.last.date
    to_date = next_trip.date if !next_trip.nil?
    truck.expenses.date_between(date, to_date)
  end

  def diesel_expenses
    # exp = Expense.where(trip: self)
    ex = []
    expenses.each{|e| ex << e.diesel_expense}
    ex.uniq.compact
  end

  def mileage_expense
    expenses.select{|e| e.expense_category.name == 'Mileage'}.first
  end

  def total_expenses
    expenses.collect { |x| x.amount }.compact.sum
  end
end
