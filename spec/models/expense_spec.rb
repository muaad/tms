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

require 'rails_helper'

RSpec.describe Expense, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
