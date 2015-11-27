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
end
