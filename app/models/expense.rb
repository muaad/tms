# == Schema Information
#
# Table name: expenses
#
#  id                  :integer          not null, primary key
#  expense_category_id :integer
#  amount              :float
#  product_id          :integer
#  driver_id           :integer
#  truck_id            :integer
#  turn_boy_id         :integer
#  user_id             :integer
#  description         :text
#  lpo                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  date                :date
#  trip_id             :integer
#

class Expense < ActiveRecord::Base
  include Reportable

  belongs_to :expense_category
  belongs_to :product
  belongs_to :driver
  belongs_to :truck
  belongs_to :turn_boy
  belongs_to :user
  has_one :diesel_expense
  belongs_to :trip
  belongs_to :account
  acts_as_tenant(:account)

  def category
  	expense_category
  end

  def self.total
    sum(:amount)
  end

  def entity
    dc = diesel_expense.diesel_company if !diesel_expense.nil?
    driver || turn_boy || product || dc
  end

  def total_before
    Expense.where('created_at <= ?', created_at).sum(:amount)
  end

  def is_dollar?
    currency == "US Dollar"
  end

  def is_shilling?
    currency == "Kenya Shilling" || currency.blank?
  end

  def self.dollar
    all.select{|e| e.is_dollar?}
  end

  def self.shilling
    all.select{|e| e.is_shilling?}
  end

  def dollar_amount
    if !trip.nil?
      trip.mileage if is_dollar?
    end
  end

  def self.total_dollar
    dollar.collect{|e| e.dollar_amount if !e.blank?}.sum
  end
end
