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

FactoryGirl.define do
  factory :expense do
    expense_category nil
amount 1.5
product nil
driver nil
truck nil
turn_boy nil
user nil
description "MyText"
lpo "MyString"
  end

end
