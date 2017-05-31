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
#  quantity            :integer
#  unit_price          :float
#  account_id          :integer
#  currency            :string           default("Kenya Shilling")
#  dollar_amount       :float
#

class Expense < ApplicationRecord
  include Reportable

  scope :shilling, -> { where("currency = ?", "Kenya Shilling") }
  scope :dollar, -> { where("currency = ?", "US Dollar") }

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

  # def self.dollar
  #   all.select{|e| e.is_dollar?}
  # end

  # def self.shilling
  #   all.select{|e| e.is_shilling?}
  # end

  def self.total_dollar
    dollar.collect{|e| e.dollar_amount if !e.blank?}.compact.sum
  end

  def self.total_shilling
    shilling.collect{|e| e.amount if !e.blank?}.compact.sum
  end
end
